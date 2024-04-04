{%- macro event_type(table_name, column_name) -%}

{%- set event_types = dbt_utils.get_column_values(
    table = ref(table_name),
    column = column_name
) -%}

    {%- for event_type in event_types %}
    sum(case when {{ column_name }} = '{{ event_type }}' then 1 else 0 end) as {{ event_type }}s,
    {%- endfor %}

{%- endmacro %}