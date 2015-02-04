% Neurons circuit performing behaviors

sensory = [24 25 72 146 147 155];

Asens = AgapHermSparse(sensory, sensory);

AsensChem = adjHermChemJunctionSparse(sensory, sensory);
imagesc(AsensChem);