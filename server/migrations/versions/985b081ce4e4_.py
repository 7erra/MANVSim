"""empty message

Revision ID: 985b081ce4e4
Revises: 06903a4c678d
Create Date: 2024-06-25 13:26:50.636712

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '985b081ce4e4'
down_revision = '06903a4c678d'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('execution', schema=None) as batch_op:
        batch_op.add_column(sa.Column('name', sa.String(), nullable=False))

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('execution', schema=None) as batch_op:
        batch_op.drop_column('name')

    # ### end Alembic commands ###