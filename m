Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754567AbeBGQba (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:31:30 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:50133 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754254AbeBGQb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:31:27 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180207163125epoutp029473513ba11681d2746fef0fd32aab28~RGCJnzdQX1600516005epoutp02a
X-AuditID: b6c32a39-47fff70000000fc5-26-5a7b29dcbe69
Subject: Re: [PATCH 8/8] ASoC: samsung,tm2-audio DT binding documentation
 update
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, jcsing.lee@samsung.com,
        sbkim73@samsung.com, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?=
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <67a9f473-0eba-b3d0-ae92-5602658b6958@samsung.com>
Date: Wed, 07 Feb 2018 17:31:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <CAJKOXPeRFgJQpUTeJeYYo+qqAxkT1iZczSJQzRzn3O3bXmvOZA@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7bCmvu4dzeoog43rxC2uXDzEZLFxxnpW
        i6kPn7BZzD9yjtXi7f5uZovz5zewW3y70sFkcXnXHDaLGef3MVmsPXKX3aJ17xF2i4srvjA5
        8Hhs+NzE5rFz1l12j02rOtk8+rasYvT4vEkugDWKyyYlNSezLLVI3y6BK+PiwZeMBVd5Kw6c
        vMnewHieq4uRk0NCwETi9tu5zF2MXBxCAjsYJSZO2MsE4XxnlNg57Tk7TNXEqV+gqjYwStx/
        coMVJCEkcJ9R4sMzXhBbWCBIYurpc8wgtoiApsT1v99ZQRqYBd4xSZw5dQcswSZgKNF7tI+x
        i5GDg1fATqJ5txiIySKgKrGihw2kQlQgQmLh1KeMIDavgKDEj8n3WEBsToFgiYWPNoLdwww0
        /sWXSSwQtrjEsfs3GSFseYnNa96C3Skh8J1N4vODXSwQD7hIXH21nxnCFpZ4dXwLO8heCQFp
        iUtHbSHq+xklTqxpZoRwZjBK3GmfwATRYC1x+PhFVogNfBLvvvawQjTzSnS0CUGYHhK9N/Uh
        qh0l1m9/wwIJqw4mie83rzBNYJSbheSfWUh+mIXkh1lIfljAyLKKUSy1oDg3PbXYsMBUrzgx
        t7g0L10vOT93EyM4CWlZ7mA8ds7nEKMAB6MSD6/BhsooIdbEsuLK3EOMEhzMSiK87uzVUUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5AwJcooQE0hNLUrNTUwtSi2CyTBycUg2M5VYhkiUebA+N
        D/30l2puN3No9uhdvjfs5eUJFp4sB9Q3JLzL/bxySqvqrYqdM7d/ZTx3niM07EmmQfn6lYf+
        dfTZeAglXfz4nrNgXq/nVPuLy9bpibw+fW/94rjuwhOPmvXWrBcMZbhjGsb3Vm/dXGf5fO8Z
        b1U/XSln8M5pd/H1fv1k6do4JZbijERDLeai4kQAgFZF6z4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42I5/e+xoO5tzeoog7YlphZXLh5istg4Yz2r
        xdSHT9gs5h85x2rxdn83s8X58xvYLb5d6WCyuLxrDpvFjPP7mCzWHrnLbtG69wi7xcUVX5gc
        eDw2fG5i89g56y67x6ZVnWwefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlXHx4EvGgqu8FQdO
        3mRvYDzP1cXIySEhYCIxceoX5i5GLg4hgXWMEgf2L2OHcB4ySiycvoQdpEpYIEDi+NEbYLaI
        gKbE9b/fWUGKmAXeMUkcmHURqr2LSeJFxy4WkCo2AUOJ3qN9jF2MHBy8AnYSzbvFQEwWAVWJ
        FT1sIBWiAhESnSvng1XzCghK/Jh8D8zmFAiW2HphJwtIObOAusSUKbkgYWYBcYlj928yQtjy
        EpvXvGWewCgwC0n3LISOWUg6ZiHpWMDIsopRMrWgODc9t9iowDAvtVyvODG3uDQvXS85P3cT
        IzBqth3W6tvBeH9J/CFGAQ5GJR7ejk2VUUKsiWXFlbmHGCU4mJVEeN3Zq6OEeFMSK6tSi/Lj
        i0pzUosPMUpzsCiJ897OOxYpJJCeWJKanZpakFoEk2Xi4JRqYJT/xXK/vMFk2/6iCjNlZtEp
        /43S/EUnsHz6UXH1YVFbx4T8r5++HN2izW97pWhlgdsZf595gb45lj77mQXrOzp2bOJ0zSvY
        Wxkjfsn1uGys1dayCK1bK3W2lATJfVL5+UNsA+v/zwmzA1qNLSVf8eecitS50tolX7m7ptPw
        6jnJzK7uC+GblFiKMxINtZiLihMBZuawZJYCAAA=
X-CMS-MailID: 20180207163123epcas1p31418a6e72f16d0938c41f6e6b840ebcf
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180205154537epcas1p10a9a30a574e3f472358e7dacf3cb0489
X-RootMTR: 20180205154537epcas1p10a9a30a574e3f472358e7dacf3cb0489
References: <CGME20180205154537epcas1p10a9a30a574e3f472358e7dacf3cb0489@epcas1p1.samsung.com>
        <20180205154403.13520-1-s.nawrocki@samsung.com>
        <20180205154403.13520-9-s.nawrocki@samsung.com>
        <CAJKOXPeRFgJQpUTeJeYYo+qqAxkT1iZczSJQzRzn3O3bXmvOZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2018 02:05 PM, Krzysztof Kozlowski wrote:
> On Mon, Feb 5, 2018 at 4:44 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> This patch documents additional entries of the audio-codec and
>> i2s-controller properties required for the HDMI audio support.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>>  .../devicetree/bindings/sound/samsung,tm2-audio.txt        | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
>> index 94442e5673b3..f5ccc12ddc00 100644
>> --- a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
>> +++ b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
>> @@ -4,9 +4,13 @@ Required properties:
>>
>>   - compatible           : "samsung,tm2-audio"
>>   - model                : the user-visible name of this sound complex
>> - - audio-codec          : the phandle of the wm5110 audio codec node,
>> -                          as described in ../mfd/arizona.txt
>> - - i2s-controller       : the phandle of the I2S controller
>> + - audio-codec          : the first entry should be phandle of the wm5110 audio
>> +                          codec node, as described in ../mfd/arizona.txt;
>> +                          the second entry should be phandle of the HDMI
>
> AFAIU, this property is still optional so the wording should be
> different. Maybe just add "optional properties" paragraph?

I'd like to keep the second entries required in the documentation,
and the driver would still be handling the case with just single 
entries.

-- 
Regards,
Sylwester
