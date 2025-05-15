import matplotlib.pyplot as plt
import numpy as np

# Data
mechanisms = ['Immune', 'Genetic', 'Microbiome', 'Age', 'Environment']
labels = ['Therapy Efficacy', 'Immunogenicity', 'Safety']
data = np.array([
    [5, 5, 3],  # Immune
    [3, 4, 1],  # Genetic
    [3, 3, 4],  # Microbiome
    [2, 2, 4],  # Age
    [1, 2, 2],  # Environment
])

# Prepare angles for radar chart
num_vars = len(labels)
angles = np.linspace(0, 2 * np.pi, num_vars, endpoint=False).tolist()
angles += angles[:1]
data_closed = np.concatenate((data, data[:, [0]]), axis=1)

# Vibrant purple tones
vibrant_colors = ['#800080', '#9932CC', '#BA55D3', '#DA70D6', '#EE82EE']

# Plot
fig, ax = plt.subplots(figsize=(8, 8), subplot_kw=dict(polar=True))

for idx, (values, label) in enumerate(zip(data_closed, mechanisms)):
    ax.plot(angles, values, label=label, color=vibrant_colors[idx], linewidth=2)
    ax.fill(angles, values, color=vibrant_colors[idx], alpha=0.25)

# Labels and styling
ax.set_xticks(angles[:-1])
ax.set_xticklabels(labels, fontsize=12, fontweight='bold')
ax.set_yticks([1, 2, 3, 4, 5])
ax.set_yticklabels(['1', '2', '3', '4', '5'], color='black')
ax.set_title('Mechanism Profiles Across Peanut Allergy Metrics', fontsize=14, fontweight='bold', pad=20)
ax.grid(color='black', linestyle='--', linewidth=0.5)
ax.spines['polar'].set_color('black')
ax.spines['polar'].set_linewidth(1)
ax.legend(loc='upper right', bbox_to_anchor=(1.3, 1.1), fontsize=10)

# Save the plot
plt.tight_layout()
plt.savefig("mechanism_radar_plot.png", dpi=300)
plt.show()
