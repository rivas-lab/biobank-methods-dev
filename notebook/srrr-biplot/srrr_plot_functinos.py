import numpy as np
import pandas as pd
import matplotlib, collections, itertools, os, re, textwrap, logging
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import matplotlib.patches as mpatches
from functools import reduce

def plot_pca_ax(plot_d, ax):
    ax.set_aspect('equal')
    ax.scatter(
        plot_d['x'], plot_d['y'], 
        marker='x', s=(15**2),
        color='blue'
    )    
    ax_max = 1.1 * np.max([np.abs(plot_d['x']), np.abs(plot_d['y'])])
    ax.set_xlim([-ax_max, ax_max])
    ax.set_ylim([-ax_max, ax_max])
    return(ax)
    
def plot_biplot_arrow_ax(plot_d, ax_sub):
    ax_sub_max  = 1.1 * np.max([np.abs(plot_d['sub_x']), np.abs(plot_d['sub_y'])])
    ax_sub.set_xlim([-ax_sub_max, ax_sub_max])
    for annot_idx in plot_d['sub_idxs']:
        if(plot_d['sub_y_div_x'][annot_idx] ** 2 < 1):
            ax_sub.plot(
                np.linspace(-ax_sub_max, ax_sub_max, 1000),
                np.linspace(
                    -ax_sub_max * plot_d['sub_y_div_x'][annot_idx], 
                     ax_sub_max * plot_d['sub_y_div_x'][annot_idx], 
                    1000
                ),
                linestyle='dashed', color='0.8'
            )
        else:
            ax_sub.plot(
                np.linspace(
                    -ax_sub_max / plot_d['sub_y_div_x'][annot_idx], 
                     ax_sub_max / plot_d['sub_y_div_x'][annot_idx], 
                    1000
                ),
                np.linspace(-ax_sub_max, ax_sub_max, 1000),
                linestyle='dashed', color='0.8'
            )
        ax_sub.annotate(
            '', 
            xy=(plot_d['sub_x'][annot_idx], plot_d['sub_y'][annot_idx]),
            xytext=(0, 0),
            arrowprops=dict(facecolor='red', shrinkA=0,shrinkB=0),
        )
        ax_sub.annotate(
            plot_d['sub_label'][annot_idx], 
            xy=(plot_d['sub_x'][annot_idx], plot_d['sub_y'][annot_idx]),
            xytext=(plot_d['sub_x'][annot_idx], plot_d['sub_y'][annot_idx])
        )
        

def plot_pca(plot_d):
    fig = plt.figure(figsize=(6,6))
    gs = gridspec.GridSpec(1, 1)
    fig_axs = [fig.add_subplot(sp) for sp in gs]
    plot_pca_ax(plot_d, fig_axs[0])
    gs.tight_layout(fig, rect=[0, 0, 1, 1])
    return(gs)

def plot_biplot(plot_d):
    fig = plt.figure(figsize=(6, 6))
    gs = gridspec.GridSpec(1, 1)
    fig_axs = [fig.add_subplot(sp) for sp in gs]

    ax_main = fig_axs[0]
    ax_main.set_aspect('equal')   
    ax_main.set_adjustable('box')    
    ax_sub = ax_main.twinx().twiny()
    ax_sub.set_aspect('equal')  
    ax_sub.set_adjustable('datalim')

    plot_pca_ax(plot_d, ax_main)
    plot_biplot_arrow_ax(plot_d, ax_sub)
    
    gs.tight_layout(fig, rect=[0, 0, 1, 1])
