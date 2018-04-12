Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbeDLF3Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 01:29:24 -0400
Received: from mail-db5eur01on0071.outbound.protection.outlook.com ([104.47.2.71]:26646
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751818AbeDLF3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 01:29:22 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
Subject: Re: [Xen-devel] [PATCH v6 0/1] drm/xen-front: Add support for Xen PV
 display frontend
To: Peng Fan <peng.fan@nxp.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel.vetter@intel.com" <daniel.vetter@intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
References: <20180403082833.26249-1-andr2000@gmail.com>
 <HE1PR04MB3004EBA060BB4ADB912B186888BC0@HE1PR04MB3004.eurprd04.prod.outlook.com>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <f9ab14bd-bf0d-9c8f-d779-022b12fe3962@epam.com>
Date: Thu, 12 Apr 2018 08:29:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <HE1PR04MB3004EBA060BB4ADB912B186888BC0@HE1PR04MB3004.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.223.209.59]
X-ClientProxiedBy: PR0P264CA0012.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::24)
 To AM4PR0301MB1938.eurprd03.prod.outlook.com (2603:10a6:200:38::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM4PR0301MB1938;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1938;3:8UKCs5YQ/eKNhl/oeTSErxlQYdmWGEaJX3jI6GAcRG534He7bgsdN2IJZRfEUeJ+i3+rXv5ddW7EkIdhd2olT7IJYeL/8wCAmeZdffxpt/9yq+SZ4yF81brxyBSpw8BEIuWlH8CnbT6dsfWpzGBP/QeDPziGgp10o4D0hseuXHkjwXQxoSnPkM4z6Bxc25XMkMZ5qgy38VItt4Iy/FtvKovHYomUVfsqVDfRzn6ZzYj8YGz70uVPGsLLfSR9Rz18;25:pvTTEiRPau2gkJScDNe9vdlAlzisjfsTCK7y51O4P0aQeuCRvVfKWtN3B2UZ3yUVkMl3t2YUKgkJvCDHT9/OD1afwIKsp2JKyqKi//Gw/RqM2y5Whj8JjRPMZdOG3nTqeNQ2R0VYLQayjk38em5BK4edUPdI0Tzqr0efH48NNK/n1KgjO8E1x1QjV2LAAYNTq8j6Aam86h5XeDCUNi4J16vlDlMQFFGOxfFaY1ufI14HVVSoKsD+AvMKQhlQiKBKNtG3Lb4e89KzEKFY+qT+kuZatSDTqgHD8vRtoHYwia2GriNj2ms/I5QJ5etntUxVibZ3TTxs3PAFDTOzupAFjg==;31:/qB4yAkWVbe9WIXgosOgvxjA1jfFrThEX9oH7ocz4aWULOl5fdfmn779BG0X5gScS6BHzSUL0smRekpWjxJCUNPCOsUrY88bgy+bO/+1UFc3FBAmrhCrXmqvpulAU184NnDiqwZD2eYfw6C4ip4qWNAxn4nX0tFp7ZSMsHhvDywCIvIMoBGKgL9NgHNBCt3V1qTQQiykBxhQqGwi5jWdouv0igq5aRLen4mqptc5xDo=
X-MS-TrafficTypeDiagnostic: AM4PR0301MB1938:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1938;20:2t9GE9a4l1U0cdoO6J0N8608N4osYn5uwFQDIN6GJ2RuAVRcMeXRzqqOeSuHTRUEd8pzcKxm25+ptXFlxTCwjo+uTaOQpsg+KbmSpGdnbbF3NJwA4GC0JoPYOnBHSLD09msKiS99EOVi3ERvK8Hld+/SnCna3ZxAC7g6Yd4VT50/oTkic9jvXX+M1B9w5SI1St1xuvMpe3NgNmKr14eSVhT7Xq1Ae+ZxddOGbIB7KTW8v1RwBNXFGLN7JSkcGoKQc2Ert2DQeKr0fL8oDg5jEY/KOetwHDIBc2XX8mzeClDtOFLkBn1fMG2JliWIwzu72dJDNlGltWcADJoXr3ZlJ8LQdur/jut/6dszn9txkSMfhKMmz6XGEFYos09yiyatY8L3BupTLpb+HBJRgJlpcY7YAmhHAsJmmPBq9V9Wfaj+BHK4r8xxgWXnHc9stk/3yrxovNvg8L1ETAeq+gzsRLr2vfRl8DvXnbQsHr6/JIhYmWA9uY97Fn2VMy2KKDOC;4:Zsdq1E7g/OvpVoRJ4DkoR+W7oHTdcBpVJShTcze+id2OKLCP309lpJnp789UnzhsirRwvlexKlVbifRTn0iB7lCYgVlzUm6oLstG8Udj3gxRIGD3YXviOsLtnpeGXUXKx8IeYLBAHy1krJyYamNHocwRsE2v+HEDC9E7SZ18hh+SYjJpYLJmxoVkQQna0JPgpGy5Z4VqUdI/yIhD3WXBSUU+xsr5SPsYRgMPsm4Bxr0w6DWrAqNqjSwi1t/zrpvP9rFW3mk06oUyyvyRcndoCw==
X-Microsoft-Antispam-PRVS: <AM4PR0301MB1938CA5D97EE5C5AC2A9BD19E7BC0@AM4PR0301MB1938.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:AM4PR0301MB1938;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0301MB1938;
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(366004)(39380400002)(39860400002)(376002)(199004)(189003)(66066001)(476003)(53936002)(65956001)(47776003)(65806001)(58126008)(558084003)(2906002)(6246003)(16576012)(486006)(110136005)(39060400002)(316002)(186003)(305945005)(446003)(77096007)(106356001)(26005)(11346002)(956004)(68736007)(6486002)(31686004)(229853002)(7736002)(16526019)(2616005)(64126003)(86362001)(5660300001)(7416002)(52116002)(25786009)(2486003)(6666003)(52146003)(2501003)(23676004)(230700001)(67846002)(50466002)(31696002)(76176011)(3846002)(6116002)(105586002)(53546011)(81166006)(72206003)(97736004)(8676002)(36756003)(81156014)(55236004)(8656006)(65826007)(80792005)(386003)(2201001)(478600001)(8936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0301MB1938;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAzMDFNQjE5Mzg7MjM6d1FPMk1lYjVwOXUxWlhWd1JxZXRiSlk1?=
 =?utf-8?B?TWk3UHRPckpxMlk4TCtkUUtQdk5hNVZMdHIxMms4OEFxVFZJQnhGb1huTTdn?=
 =?utf-8?B?MWtOdGxDRWUwalRveTJ1ckU1MittZGpJajFFb3dmSlE1TWRGSmV3RkdlSy81?=
 =?utf-8?B?Y1lhVk11bGYrbkFvVytRdk56ditIYzVoVGFuSDFLWjJKcmd3K0tIams1QUZC?=
 =?utf-8?B?YUlybG9OdFByQjJENGV2YVQxZ3NoUWVuRklmVkg4bm1vdStUa0FNUmE1bStv?=
 =?utf-8?B?ZTQyWUtkQjBHTWdoeTEwUkxxV3NQM1lsTDh3TFd2UlcxMUxLTmJYT2g3cFd6?=
 =?utf-8?B?Um1GYkVQYjlYVG44azFONlp4LzBWNFhlaHNRRHJaSjJTc3NYUHBrd1VVUURx?=
 =?utf-8?B?dEc2T29sY25yUFFDNkFVWTFUMEt1OEd3Ti9WYmZQUjIyT2FKVzJUbVp1TkNl?=
 =?utf-8?B?Tit4a3FmSUV6WjFaTG9IdElFUjBoOHJvMXVEdllSMDJCZWtHRXloc0c2eHVn?=
 =?utf-8?B?bWRGR0FrZlJTelRHam5TM3k2OUZEOVF0RnQra0pLQkY1TWpENkdiTU45WG1p?=
 =?utf-8?B?c0RnUEVmZkJGUVhCNnJNWVVTTS9vdWxxRXVVWTZqZXpPRWxHVlRNclRDSys0?=
 =?utf-8?B?aFVIbTcwUnVEWEYxMlhQdTBSWEZUWDhQRjlUc3dqajZaL0dCOHYzUkU0eFNM?=
 =?utf-8?B?QUZnTnRwREcvL1dSeVRqNTRIZ2xETldFNVMxUEdleW5LVkhnTGZ6OW45MDhB?=
 =?utf-8?B?UnVjY3JNMlQ3cnhUbjYzWXhrM1RVWmlFM0ovSGYvV2ZmakQ5TDdZTklmZ1ll?=
 =?utf-8?B?WDVGdGEycWtCN2t0M3RXMnNVVHJxKzdYNGkxRnhKSU9ubjdkWCtBclVDTy9N?=
 =?utf-8?B?VDhwQmV6NENXVi96U3hJc0VrdDJYRWUwTEErYnJYaS9SYTFFRTRZYitUNnVC?=
 =?utf-8?B?eUhDNWlPRmJJem1UcDBTcGJGRFFPSDZLN0svQ3dYcUJrOEg1V0UzaDJXRzJL?=
 =?utf-8?B?OUVGTEZMZmExekUwdHhUSzA2bmJlZTRCMTR1LzFTK2JWbm0rVHJTVUdOS3NL?=
 =?utf-8?B?VTdXOXloSDNrRUplSjBWMk5XVjdvYWdlVEcwNU9oZ3lleGM0TEczNGRZL05Y?=
 =?utf-8?B?OFRmSk54V25RWnFuK2p3N3YyQ2N0QzdKcjR4cE9BWkNXeU9HV3JDbUwwYlhl?=
 =?utf-8?B?cjgyVlhudnVoUEI4a1ZFd21KeVU0YmtqZnFZbVYzYUhXSlh5bWRsdm8wRXB3?=
 =?utf-8?B?Ky96eUtSbnV0eWVuczlTN0xYd2tjR0Q5RGZxa2V2TENEV1dydXdNRlQzRTJE?=
 =?utf-8?B?dmVhRVhFSnVESzRuK2xMWWdYQnN3RHBGSDJGN08vUE4vL0RJdnFzOVdRcnMr?=
 =?utf-8?B?NlczUk9lK1ZBTStvWkxYbFdMeDVNakxOSFBZY2VzcWVRbWNESUs1SHBPTERH?=
 =?utf-8?B?bHBndjhSenBIMVhwN1luZUFiRjgzeDB0cTlTVlZTNHU5NEpMd25CTkg0YXNj?=
 =?utf-8?B?Y0JmOFc3ZXB2KzVhWFYzcGN2NlBHZG9QV3JzemhaRDhoL3lpbDFJRU1ab1Jr?=
 =?utf-8?B?ckNacXFTSFBVZ2ZtdzF2QmwzbEtYM01FVkN6NVFHUGN3OVdvUkQ3bnBRcGZM?=
 =?utf-8?B?YTZ1UUZXblV4YnVIcFVleTh2aGc1SzhPTHA1ZTgyWjFPeXVjaUFQUlg3UXNW?=
 =?utf-8?B?VmJIOWkzd3liMTNyaGNlVWpINXpXKzlURjUxVGlPWm5QQ1h4SmhZUFU3NEo0?=
 =?utf-8?B?VktWaDVEOXIwSHdnczhYNzlyNTdmYlFCTjlrTDFqN0hxRGtVVG9QczUwTWFX?=
 =?utf-8?B?QSsvdytXeFB1ZHlqUWR2aVpSamZOemtsVkhKdTZzeGZDZVdvVk9QTDcxV3dW?=
 =?utf-8?B?U2ZOczR5YUNoRHp6VlM3cEszckZwS1hPUml1WTNWemlaUHFxZWJjNzQ2cGli?=
 =?utf-8?B?UG8wMFJRbC9tekJiWGRNVHY0NGRvUElrMXFncEFUV1N6Q2t3L3VtSTZNNjFX?=
 =?utf-8?B?ejE4OVpoV2pxaC9ldUx0S1FHTTViaUM5ZWtkVHRGS2o3L1pnMVV3SmdkZUFr?=
 =?utf-8?B?MU1obUdSbHJyMmx2MmxPQVZLcW1FdlRhSmtOTmVWTGhWdjZnbnozRE15Q29M?=
 =?utf-8?B?cUtEZ1d3NzVOYnlUbCsrQm5naE9PYWNxc2tUL1E5eTJJN1lGZDBpN2tSMzNC?=
 =?utf-8?Q?GSKLF+2Pmet1OWV0lubvGbkR8WvCHn9GDI15Ie8Xap6Q=3D?=
X-Microsoft-Antispam-Message-Info: QBhqwxUTv2Zm2XNNywVjwXUjTsdP4xJFvFjzVzAEimor2vPU2pPLU35lYf0zUDNaU2ikNiLA2D+TDPj/RzVTdag9vbp7xnSBAdcy7c6F5zTu0X9dwzlGw2Mk04GkLCh/XEebcApJno5qu/gXnzW+p3pw8Nd/9xdEr7d9vOx431T2ymMhI30vZIv29VqsMIXq
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1938;6:UZZQauodhI9N5ympC69z5G4LJ3MzRw/o0djhkWvan3gwGiTn8h2ekIpIWRvONhOMIxnKAmQ+BD1xhFzy0FHYKkxJye4VzqIBfNPtcMqoCRmzfmu4asbNxL9AVfxhvQpe2etB2T5UY8X47dGZNPg1OS/vjNRyJy6bvdOJVpkrvB5L1KFBkfN8Vkp63/PD21a5o34ZCZm6CPJfGB/VWHwKclnugARgVrzOrcAwa1B0e+Ng7lX3nUnKye0aU0Qc8+ZAeBAV6OXCh0pz6aq9r+0YnxrvGWY3k2mQxib0cgXlgNZQQ5frFNNaMpxYUlsk9VUDvDJzbuTr5+1ri3ix5mwcPYegH11C6Kh5kUm8fR4e4b6LhrZG+OEjZutFkcVIVs6kml0vOiI8Pwfyls1M+5coDrmjGwnx/dIkR0jUnKugTa3ZffrqORKfc78E1VwHJvrEblZkabcOYbvDpcRIA35HGw==;5:a+i5YzARZVUdpzRM2jdUNdz2eJ7OMplpxcB9Wt9tvE0beXklL2UiZIDwpyfuLSTFpQWjbTAVGQwhVrqbWlXGFUiOT9rks0MAj4x8fQprsMM87t5WJjmp1WYTMnjDNDze7cQilz48mq1gp3Bf9k+bvLZ9924iei9XLx9JEC3NW9M=;24:u05Hbvxw4z688pTfaTQAPWsrAeK+r/gZwS67xUkD5pqjOuMeuhkwm92oYQQVg779m/Cy1tsrFQD0d0E/j0ysnbkEjYIBPs2hj41tXFsyl8o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1938;7:pAVlqitD4exU2mg/BwarYo44qVhcI2dnZOIWPhcnMtJVN/UMH1IhWuSLoXKcCfno0pqra7WRIOgj99knPNLNkyh67MDvtcCvmAumpJpgIshSDG0sW0RFfPlN1jN5KfpR6oBukBBZwfHGAYNX5rFfRb5EVdXgvbn79KtmNHhJ++dZIjUUCw1pvSXkMxD4q1RBHGAhY/1PXrGLu1lB6Eppsqje5w+yR4C7vg+/9WL3X6XHhpSAnxBIcI4eDbGcahbd
X-MS-Office365-Filtering-Correlation-Id: db4d173d-40d6-46f7-8fb2-08d5a036573e
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 05:29:18.6595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db4d173d-40d6-46f7-8fb2-08d5a036573e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0301MB1938
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peng!

On 04/12/2018 05:21 AM, Peng Fan wrote:
> Hi Oleksandr,
>
> Just have a question, is this drm/xen-front stuff orthogonal to xen shared
> coprocessor framework for gpu, or are they exclusive?
They are orthogonal
> Thanks,
> Peng.
