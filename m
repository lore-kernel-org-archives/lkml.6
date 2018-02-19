Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeBSE2G (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 23:28:06 -0500
Received: from mail-co1nam03on0085.outbound.protection.outlook.com ([104.47.40.85]:3430
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751840AbeBSE2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 23:28:03 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naveen Manohar <naveen.m@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <20180219103245.54d9ec8c@canb.auug.org.au>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <3201b67a-5453-8bdc-00b1-6617ff640876@amd.com>
Date: Mon, 19 Feb 2018 09:57:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219103245.54d9ec8c@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR01CA0094.INDPRD01.PROD.OUTLOOK.COM (10.174.56.34) To
 MWHPR1201MB0191.namprd12.prod.outlook.com (10.174.99.13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf98daa1-3e46-4987-e85b-08d577512902
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:MWHPR1201MB0191;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0191;3:0DmcSVxfAxppO6XrxotEsblzGd7AAwpv2dXXhIHzMjJvxTkzLtC+QnEsmq/CFHfTmPKfSf5xuEZfSLKga925+SaJ5tWahF+EJ3ukcLbxz/lBFYAD0F/rEaLevSP1Gtg9zJ2xtu8nHsxgtK3BKCt+qV5MY/xXJgH9WFP1GoY1Aq7MyxANdYx5kVHXAJAy9WrZfvLRDjTjXQFm7yZkW+jIvPVIbuhie9/b7ZmgFRo1nHzs484g+ZnSBIjOFoiB95DS;25:htp+1R7KbwqXdncFadwwd42ID5PC7eBcuFy5/QXOx0yzAP2wC0W3W3oyUGKtbF3APHoHXMt3imUbzKvaptwfqkkmKYPrIY5/hZUTgJ7NvckNSnSwW7BfSov6L5Ev25Tk3FxMRgXrBFS10ZbRwXcCr/YKHpcSt+7B5uZ46tXXuV5v2YJXNfaeG36rqNk4L+I1kkhtLqTL0cY4kMMZ4OP0skVYUDoBVxUPHz7l6AcYcIAZLTxVerLX3xkHEjb/H5Sfj0mlWhFDSNCfaeGwqW/OL65SYYkZ+Wrxh6rnxyQb2lDmefW6GGCTsltYUcxkvVo/h2XIuccsw/UY+5fsSGOZ6g==;31:4Mkk8ystY2MOqXxkAp+cXosr2GBhxr+AqBfOkKxkXLsrAiqiZGHW+hM8Wo7QFpMyO9MvgxSyAEdT3rLoig9AUCP+IdzMPaK71UlD1+b2XScO+NPCHHrNh7r9rRO+HMkpnAdL63GHrBSvq+rIzBdXTHo6lcYpNT1wG4nGrjdScSq8bjVTZN3rqqpjvlGcQfhhiLxs76Qa5FJgQUQzl9qSedqLw82//r+wTSQMCh4eVEQ=
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0191:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0191;20:NwIb0TedepwgpTa6nZqW7xIhP+vzoI55D7MOOlBghgonhLnNXgXn19m7OuNeSE1c8qWS9ujXF2OnB+UjTfdN4GrwUhcG4fhQo97qSx8MvlWt2h8n/9/jZe0QmUJW0+RSjAhXmuGyS87GxKIVhmgjHoAPqb6FScsZW8sUMoatVr0FC+xwGONJ+YPCt3selZJf7OV1zAOcELtr73wcnzxFEYCTF/2qO+kM0vA4BYgyV8Qh3EULOIohUHXL7EFQVkKK5f8Czd/uWu4JOKIt9tF6s+a6g2ONsgrFMYsQosN+JTDsEhKE/BhQtUaIumU1z/FIZJpej3gc18ZO8yIFDC7zQwie0OjUrws6gKMP7HTGtCaFjcfz+E2ynPY6BJza0kF+21Xtu23AdTqtMyHx6VmWTJA646P4qp0h6szLYUagDUzGBw9DOYtLzFBSoJyY+aONt+3ndau6CFeSb6qnzf4sHHvcJ2UurxryZ+3rdpbPnsJ4mJTNmSSYi1/WT5HeqLWV;4:bOmmLc6z1PeLeJxuANw2v05ci6cT405oRYszHlJxWFtdarIfthyI5ecFdLf+5UN4iSA9eiyI5Lw2BsqtjNTJQ3jQxrIU8gblumiU0JR+DBcp4J38u2bq9p9hWUERoSrV5lkWOqIextW/iQr5vN3IGaw/YVJire48h/yir4qTK+my1CUlK0BfANfOvq7q21ZWeJZ13WByi52ZYHjQ15+/gzfKlAWdSlUSEFvU75xuEvTGjXZBYwo/mFTw3e2qfl6NsPl9Y5OUsBw6G80SHGTzibaVlql2mH46RS74l+5p2/yJ1Xa7/MEIbhJTkSHBDsoc
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0191AE06365D88B3EE1E293AF8C80@MWHPR1201MB0191.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231101)(944501161)(6055026)(6041288)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR1201MB0191;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0191;
X-Forefront-PRVS: 0588B2BD96
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(366004)(376002)(39380400002)(396003)(53754006)(189003)(199004)(67846002)(83506002)(23746002)(50466002)(36756003)(3846002)(230700001)(72206003)(31696002)(52116002)(6306002)(6246003)(53936002)(3260700006)(25786009)(90366009)(58126008)(54906003)(110136005)(478600001)(16576012)(106356001)(68736007)(966005)(31686004)(316002)(6486002)(53546011)(386003)(76176011)(47776003)(65806001)(77096007)(186003)(26005)(16526019)(65956001)(39060400002)(66066001)(7736002)(2906002)(64126003)(59450400001)(305945005)(105586002)(86362001)(8676002)(65826007)(81166006)(2950100002)(8936002)(6666003)(81156014)(5660300001)(6116002)(4326008)(97736004)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0191;H:[10.136.128.119];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;MWHPR1201MB0191;23:4kOYrUiSO1LP++uAPKtSZz5hi6yQVqryGs+?=
 =?Windows-1252?Q?aGK1esnsvhjFLcx9UKUpW3q4jWxnprN3I+uP0gjiSSDpFynavQ0u5Qkn?=
 =?Windows-1252?Q?EgsBpm2N0h8gToIr9+yA0ePdKF4jpn8Gs0NYvzv5B2FYQWwyEqldSR72?=
 =?Windows-1252?Q?iNW/bb3LZ2iGaou0VeeSibZopHL8vbm9zroScYONtgkXoLDS6/sJtYQc?=
 =?Windows-1252?Q?ewEdPjEvoBiL4H5MhyuPgTVFssIqFibHHhSDe6/AdfOWQS2TnXDS/YjU?=
 =?Windows-1252?Q?kK7kE32MN8k4bU/Hov68lieARGBnxSjS7xmusVAWhiXI80sTX03E11UX?=
 =?Windows-1252?Q?f9i3IZ0wlYslzNzi08y6n6rh+JlN8bruXLxKAJtm6YUjBLoYMih1grKE?=
 =?Windows-1252?Q?B3Q1oPwXulLYQnXCZY1Ui+fsrxE0K7Wh9oIlmcYITIUBcVI7hxCqoDDW?=
 =?Windows-1252?Q?TG53reUT7fQVXILX5hKfD1b4yS2c3Dw5gWWByNLPcWLTyF8nVpzjAltO?=
 =?Windows-1252?Q?Sn99S8lmRljoS6FHDepfCVub3oM5Xrx02/QIHsPnok51HY4j/ao2mjoS?=
 =?Windows-1252?Q?tfuJ2uBORS0W1n2sIVg7m4d2FrjWcW40OVpCVVA4VPLq0YlhdYcud95n?=
 =?Windows-1252?Q?4Ub7Wv9f07o7gZR8FC8LhMrrFla5PIPIAUixKJgZSI5qoeIw5YYgQsVB?=
 =?Windows-1252?Q?PUiafTcAUS9UwnG2eiNVwPadPaGEJ8r8qMM804VDr8DYVf8SFSMRq5xe?=
 =?Windows-1252?Q?wMDiY6iGsKqIR9krZWiHXQ+z4TG+drpPHRAkDmRHKbQVJXP2qAW/xhlI?=
 =?Windows-1252?Q?8/oyPopXVZyEcPoiBpcfgfiwDbAsUqfwXxdmldiJ6QflpMwqt3L2oJ8m?=
 =?Windows-1252?Q?zhUpvwcnkRWT3OSmxGVY/jL/nB+6LiQSVmLiIbqmajpdPciHuKOhvGwW?=
 =?Windows-1252?Q?zCZKxLCS1wV4Dd8F1GAYr976d8FkaHeX/J2nPaDJsNlaSSDDYqkzjCZi?=
 =?Windows-1252?Q?tVPsR8m8hIDVPlxohPLEDQTEpkb4Ij5koDOvIrZY+CjBWPZgto2WXSUr?=
 =?Windows-1252?Q?2D5Yrgkemv/7yf7JuXkAxFWldcp57mpK+/0nvJm2DW6pas5ebBpx6T9b?=
 =?Windows-1252?Q?qVPKBOYY165PIKVYeVJR8n6kgfGfPj/NkQ4rY8ulfJ1NdMOgczSDa1sQ?=
 =?Windows-1252?Q?fRLTgPMLq19g5rz8yXMi7GTtnBSK423q/TU2/xQXfibTEcZQHafRtpWh?=
 =?Windows-1252?Q?n6SxbP4yy/7LODh65RnVDvmoAyy4muqmiaKvqO5p2FR7dHQv0LPeRn9B?=
 =?Windows-1252?Q?l+9diN+NW9Ce1vIGlpL1UbDQzH5xL20OSbAVfYR2B9kR7B4k0S3MsvuX?=
 =?Windows-1252?Q?P2M4CHGhG7xTFVJ9+oGM981HSrUjBenIbqLtFFDiDoUEFs6yk91SNOOw?=
 =?Windows-1252?Q?a4NmdjOZWk4jSNWHCjmkktWkBAh0Kw1bfXzzATY+NQ8cFdZfoujhH9b0?=
 =?Windows-1252?Q?TnORuPDQXpqiHtipBed/aU+sCORDK0L+kUw6FndBtiXu+I7AKT+hlP4h?=
 =?Windows-1252?Q?4G3QMVNvLaLwRpfHYhLAmAYF5YyQYFbMBOGrLH50H6HS3EwXgn1Z3rDQ?=
 =?Windows-1252?Q?Tm4xVMJ2zrgSLqk9PSoj/sBkIApQGwgtwDqtin9qkjA0Ld/yZTZucRQM?=
 =?Windows-1252?Q?ClezEX0FwlQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0191;6:tliaQaQFv7TZWGTiCxOEMHQ1r1KaaxiXGo1oMQtCjjiPSOBhiAMhq7oegkMXnsEYvbM75KzphMN5KUskRv7gg1DIP/N8GfPhiw5F6sCrmAtYLRP/cVqEFkRxSIvjmJBHRoj9EJS9Vqaj2brMlRcgC0UEeZvzJZUW8PUyOiHW80TTKRchAb1URf91rsVE1p+cNbuzMM4zLcfJPZH+oL6nI5ccyCF+CLaG3ePvUT/LYiQehSvP7Y9iGWIYccvdLzfWCtEYz/MRil9NnYLkfJgHGoH144mgOJo3yLNPIiTmYC7OblEqrMK0d6cYyoIQCDclBkegTDp0SuJ4sSrI/tWv3Va0EtHCljPj/Cl7OvzL2lU=;5:6St/JyzSHGgJKKFhKjsRTGagaMutROdxGl1+QK/g/y2bDiAfrT4P2ydbwOvcaY6hVyhanIZcBuHr5SNOntV0i6JheiQOxIrTWR1aSrhN4uP+kvcbiwlSYTzV0MB1x5CZMrNtvpcW2WpiVEup0PWkQqB37MAmPxy2jhWwW8bOpKU=;24:SUP//BBscC4Cbh6vdyS2Jldes5MJYyEhuO7UxzZ7sqw+cXHcZZR033KP7NSYq1wEnav8goRY0QOg6NanckuBmwpIH1yAU3MXqeAyeDoUP5s=;7:I9AvqoYNvjPa/0sP2RD0eUVI/QE72K9NXAGf3LCTuzZEt94hPW/MRoIQbzt2IPHCOylYfykl4Tz9kzhtuTxrvA5x3UQE7wG15iLw+pqq4LnF9bXka4J9kHyQJQGZ2+gqhAcnW2I1ytdeJuV2TxB0NV/wPxfd66J81aJ0tCz5v9DcV9S+AeByjRKjo8DA1K8PKDxhTxiosYuHWwkteUwEqLbSBwWUJ1r0ZDDo0JGoWKMGCBKwTgrsNVMqu8xPhZAi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0191;20:+a/KU1e/hDq1nfKGYslaFb/Zl3qwrbNgNNDrhj8hF7K55fMDfsog2X7DBrCRggkfKDoF5cgR/sCQViWciFFYGfNUuaFn2ASDh0J1SAqe1NkuATeRsknHmJ9aI+Q6QcxsyaiQNXkn3XAYmHAaXoNM41n8fIVFj0CqG/D4HN0uWWMujKe4HJfB/S8eBVZJ0dF3Jt7HiUNSRZOiNxdxgxIMHDc31vQRf+iogPmWw2aE1xR10HKMjmGyOgl6St1kPiu8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2018 04:27:58.5030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf98daa1-3e46-4987-e85b-08d577512902
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0191
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/2018 5:02 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the sound-asoc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> sound/soc/amd/acp-da7219-max98357a.c: In function 'cz_da7219_init':
> sound/soc/amd/acp-da7219-max98357a.c:79:22: error: passing argument 1 of 'da7219_aad_jack_det' from incompatible pointer type [-Werror=incompatible-pointer-types]
>    da7219_aad_jack_det(codec, &cz_jack);
>                        ^~~~~
> In file included from sound/soc/amd/acp-da7219-max98357a.c:38:0:
> sound/soc/amd/../codecs/da7219-aad.h:209:6: note: expected 'struct snd_soc_component *' but argument is of type 'struct snd_soc_codec *'
>   void da7219_aad_jack_det(struct snd_soc_component *component, struct snd_soc_jack *jack);
>        ^~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> sound/soc/intel/boards/kbl_da7219_max98357a.c: In function 'kabylake_da7219_codec_init':
> sound/soc/intel/boards/kbl_da7219_max98357a.c:194:22: error: passing argument 1 of 'da7219_aad_jack_det' from incompatible pointer type [-Werror=incompatible-pointer-types]
>    da7219_aad_jack_det(codec, &ctx->kabylake_headset);
>                        ^~~~~
> In file included from sound/soc/intel/boards/kbl_da7219_max98357a.c:23:0:
> sound/soc/intel/boards/../../codecs/da7219-aad.h:209:6: note: expected 'struct snd_soc_component *' but argument is of type 'struct snd_soc_codec *'
>   void da7219_aad_jack_det(struct snd_soc_component *component, struct snd_soc_jack *jack);
>        ^~~~~~~~~~~~~~~~~~~
> sound/soc/intel/boards/kbl_da7219_max98357a.c: In function 'kabylake_card_late_probe':
> sound/soc/intel/boards/kbl_da7219_max98357a.c:552:34: error: passing argument 1 of 'hdac_hdmi_jack_port_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
>    return hdac_hdmi_jack_port_init(codec, &card->dapm);
>                                    ^~~~~
> In file included from sound/soc/intel/boards/kbl_da7219_max98357a.c:21:0:
> sound/soc/intel/boards/../../codecs/hdac_hdmi.h:8:5: note: expected 'struct snd_soc_component *' but argument is of type 'struct snd_soc_codec *'
>   int hdac_hdmi_jack_port_init(struct snd_soc_component *component,
>       ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commits
> 
>    608a300fc1f0 ("ASoC: AMD: Add machine driver for ST DA7219 MAX98357")
>    b3ea70ee64ea ("ASoC: Intel: Add Kabylake-y Dialog Maxim machine driver")
> 
> interacting with commit
> 
>    451011221711 ("ASoC: hdac_hdmi/nau8825/rt286/rt298/rt5663/da7219: replace codec to component")
> 
> I have used the sound-asoc tree from next-20180216 for today.
> 

Thanks Kuninori for updating the patches with fixes for the above failure.
https://patchwork.kernel.org/patch/10227101/
https://patchwork.kernel.org/patch/10227099/
