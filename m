Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZrJVygLf9Iz9N1u+mek+ZRKtjGQxBapU9XpKwq+q/R2ZGjcRBVpkgh2lS6aoxl/xhsXcxNr
ARC-Seal: i=1; a=rsa-sha256; t=1525674256; cv=none;
        d=google.com; s=arc-20160816;
        b=blpbeW0G77lKtsQczn/6QBVtsBjUtOOimZurld45B6QmXAxIwvwUQ3UwPzVjUfR5TD
         b2SJNDwbXdBryq9+fpyhqyBZiwygXOP75tZjv8f9fdPCLV4xj5FHs4N9n4wlnoaeFQHa
         MxauENvCi1QWi9ob9kvdRkIGh6/2MtuD6NFIKT+ZoFYKdGDAbz+lmVWaqU/0EcEO2gbk
         +nw/LobXhSOcavnjVQdREskyoZci3tCOVa99GsRSsm+waq6kmD83SKFLcdT3d+t1STnf
         RXtJlo7jnsXBPpw6Slq+TWIJ/6elvfPPXYRlW/yxuoaEzugLhvoK3obBUDCercBNQxnY
         6Zzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:to:references:cc:subject
         :dkim-signature:arc-authentication-results;
        bh=yiR+YaRlbFQXwKHUQhE9LOO94UddClk83KFK8hYmAkw=;
        b=cvv3f6se7WbFCJbjGhh8+B5TeeDL9pXUEQvFQeX5VCRYUyd7QFjNZ+i6oXJvQl/Sqx
         ElJtn0fUFbBXLSz2bMzmKDvsBQRiLa8NYgqFEZpYqot7oqN/xBxc4qUxYXTnkg7Xt12w
         XRZ4+s0Mw7oyGjlGLuvTibpmYrIpHcCe7kns+9pgKAMmWPceytKsY7jmV4X/WrQOhFyF
         KJtZWXuQsnOwIZ/PCaDkmV1/vAvLeAAXxewCCXmTYCwkQpPUbZCjHqTylEt6iSHL+Hyg
         nti+Pon2Mi9Sxwww3VGQT6RBwyOoGY+dhVza8ZkQAXlcQ+hWqWAeiDgUIbwtk+Y6xSxT
         oH6w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=bkLmYyNe;
       spf=neutral (google.com: 104.47.36.79 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=bkLmYyNe;
       spf=neutral (google.com: 104.47.36.79 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com;
Subject: Re: [PATCH V2 01/10] ASoC: amd: dma config parameters changes
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jason Clinton <jclinton@chromium.org>, Akshu Agrawal
 <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>,
 djkurtz@chromium.org
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
To: Mark Brown <broonie@kernel.org>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <e53cd47f-ac63-93ca-9751-f9185d94d17a@amd.com>
Date: Mon, 7 May 2018 11:57:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: BM1PR0101CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::17) To DM2PR12MB0316.namprd12.prod.outlook.com
 (2a01:111:e400:50d0::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0316;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0316;3:U6dyTgnAP5P7nbXKH648lF5wULNVjIDbF4xPMcE0tEMg3Otnmh+RfCUCK6ZcQRh3D1hfLWMmDL6voiAHnozMqOkJP9503LtEvjCpbmi/bsOBwuiSYjk5h1GWho3NRezWatxzuWBG+5YBSm+s0AoVugDkRPUguz5Hob1IDoqOGaVriAf16EHCOAG4sZxDuRW/qjKKLQwuMF4XTUTA3fV+0bxtT9Px30ilHfbdnFXsCi7ehOvhX73N6q2XheFmWgwr;25:F+2Dt+fGNZdDZoOXFhcNmCbe4npXA/QChOtTDFwKLmqjWxiXjdOuYAV8XbyEPMXbZsr4pVLvl8PECS29WRJD9/Xu/2jAX7vUIqqr8gfWeSErlEq8KCBKgJxPRvjvchhpVI516EaWf/FuOqdM8/IWDBij2jJEGNl45r3HooJTuH0hKEYCuxI6iPHOuwmohG9oODamwI3ukgbGmN7pZqiEHILTkwpdLAe6Npyg+0oOaEZR5p/BDQMoC6gCOTLye6MeYFE4AEZOD0FJwM7vFZpJKlmOSfkr5qNhdUy4e/u5l3/O4axGPdS/H69qUU+vCGl86lw+bjww4clGNKhdUSicBQ==;31:TNxQ+jeXKLtvXJRsgNjCWIGex7RQOlknVLVBuv0GHRHwYSW306BKunmxfCq8pXywwQd5jDZLQtxmXJBSEy0CwAjN8OcfSKnaYBihkwz634WEP+2bAQK8sTVGmLxbgluUlOLJ5G1xwZclaVboCGirQBfeBiKfGmTXJo8qAkx4Y0KQ7gwWF+NclfNXpU7txAzO+PmvVexWPusA99O3E5v+Pfh6ptrQhiIc02YXu2xmAt8=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0316:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0316;20:E80h0UXCbbqmn8oF9qohAF5S0499YFLiYyjhnyCcmD7qBU+8YX+KIOWPBUOcT+hc2+XDwiH/lfLwSBSLwc+EzwIYuQKkmVbf9/UCz/3X8vLMzksh4U3Q3VTiZsQh1bvQbTR33Nh2eZ+4xzLSJIuUhz0MuAmDwRGF5lE4CVbJPdb/XSU3CKR+MgsG6lrAHr5fVdl+CMQ8chWBAbIum2UVFbn/f7o+cV7BjwmMqTcEnbXwVa0zILrRRsmEOtGuD5we1rxMArR/OpFqarQd6Gj/yh3Ae+LYbtvrBX5Jmw/C1llJZndrP6nwmeqtM9Cn/ajhhMBLHXQqWr4f5+seA4Ix7Hix8PbyFWvzXI8R6/z8H/vAC+thRRyrrIhxC7R6TTF45hoxbAFJ4Aao+4I/v1zi7aDC7l+MEBlqUZENbu26koqgNUvWxZbGqjwsqUXoYoMl3bjx6LLHCucrYm20Em0PuvLmVRoc3GpB/6yHR73+pyErzUz3hboOgfA/2H1K2vNY;4:itxQrYx5VklqPiZglXY3A+AUYd4NNNwACUeVE6NTv/7TKycSKfZ1iIbphtLiuLP6LEFqmGhGrmtxBQjhNUJVej3yeXLqudPK3WuRcKjCeK8rMzkwCeKMR7FXG79XQjWXWmogCnVdbDN/mGin4r7QfsHRzSGiZED6tl8YYA/t3Q37KHFtmoFwS8vVtaUdCIjY2KXLSxsSaIm2Vky231GmsgQBwOLeeIsmSkp3PlHA/oMaalq955FlzMssuDgUgbDRefH9W/A2UG7juQNZghwCzgZpchr/FSHt1Oo9CRBR/a1Az8jnY4IJVw/DYiikaCrK
X-Microsoft-Antispam-PRVS: <DM2PR12MB0316C9D44D9AC886E4D1A24D979B0@DM2PR12MB0316.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150023)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM2PR12MB0316;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0316;
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(346002)(376002)(39860400002)(396003)(39380400002)(189003)(199004)(446003)(11346002)(2616005)(956004)(97736004)(50466002)(486006)(6246003)(476003)(53936002)(39060400002)(186003)(16526019)(36756003)(72206003)(3846002)(5660300001)(4326008)(7416002)(6306002)(58126008)(31696002)(2486003)(6666003)(6116002)(23676004)(230700001)(52146003)(54906003)(6486002)(64126003)(52116002)(316002)(305945005)(7736002)(86362001)(16576012)(229853002)(6916009)(67846002)(68736007)(76176011)(77096007)(81166006)(8936002)(81156014)(65826007)(8676002)(26005)(65806001)(66066001)(966005)(478600001)(25786009)(106356001)(105586002)(31686004)(386003)(65956001)(47776003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0316;H:[10.129.12.246];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMzE2OzIzOjBLOEJSTm9ia0JNRGkyN3p0d1l4VnN6a0dh?=
 =?utf-8?B?VUhwd1dycENtZGJoeU1BUWhxZEhtVDd6bEVJUnN1N0NVa1oya0Q1aTcrV1V0?=
 =?utf-8?B?dW50L0libjJyczZBbTFhRWlocjc2c2VsYUcvZEtybmhJN1JOQkZLaDZaaFAy?=
 =?utf-8?B?VEhLSnQ1ZGtvV1FMRU0vZnc5THBFY0ZWQUpaYm1tTi9GN2JOaXI0L0RFVU8w?=
 =?utf-8?B?UW9IWkl2VHliS1lEMmQ2S3g3a1RxUmxaMEszelBDMi9UL3hnN1FDZUVKTlM5?=
 =?utf-8?B?bUtnWkRDTC9EaFVOcDNKOW9iZWVyMTVEdzB1eWU2ZXkzVVJlQVcxeXFsUy9n?=
 =?utf-8?B?MzFNeStHbGZPTG9jNmszQi8yTmdHQU1lOHRHY2lzWlROOE1GVHVZbmZ0d2Q0?=
 =?utf-8?B?dDBrR3Q0MFBQM2ZZdGlzZVBOSGg1cWFxQ3NvU0kyMldUcXloNjBzRzVud1M1?=
 =?utf-8?B?RXdvNGNyWEIyalRDbnBIWGtMZEdwVk9CY0VtbE5OVkMwclFLbGZ6RmlkY2NU?=
 =?utf-8?B?ZWZRMk1LMTFGd08ydVBzejJTMTRUUEVKeU1UdU5KQmdZa2ZNR1lhWFVwSzVz?=
 =?utf-8?B?MG0yU3diUFh0MFRSaFhjbVc4cFNiZTdvR2JCaFlEcktyT1JJNVUyNHR0M04x?=
 =?utf-8?B?TElBNll5OG42Y0hpeXRObUlOSXRGekc2NmtlVVRLcHBPaC83ejV0QWRMeGRW?=
 =?utf-8?B?dUxwVkFCVlU5UXZvWXRnSW9FelhmeVRWUDJOMUJKWWpTOXpJN0k5ZGRickxH?=
 =?utf-8?B?NWhrWWJUb2xYbUtITWg0dFJ5NloxMk1PTHpPc0ppUFZyRlN1amtSc20wTlFn?=
 =?utf-8?B?M3Rhd0tsaGZOMDloTFJNRy9KSCs5Tkg0czQ5Y0QvZkFYYy9qMG9VdHFJa3FB?=
 =?utf-8?B?V3VETWhPbHNQUXBWZUhSNUEzcEJGOE13UDlqNStjc1E3cTdqTWoybVUwYVpD?=
 =?utf-8?B?Vmc4b3RsMXBsaDhQeHJmaEV5dG5lOE9tUDZuQWlETnU1UFJTNzh1ZFVFemov?=
 =?utf-8?B?YmFPODQ4OTd3ZVJjNnUvN1NCZnpadlJNWUV4N0VjRXl1VTF3RzhFNzZickM3?=
 =?utf-8?B?R3ROanhrbHpCV1dvRE4yS1poS0VKanIxVG9OZHByaFJqK2tJWTAvQlRyWUlH?=
 =?utf-8?B?SEJtbGIzWWxva2dpNTJVOTU4YXlDcUJwQjljeFlnWk54VDdkRGczbjFDdEdS?=
 =?utf-8?B?LzVlcEIwNDlHMFR1K2lvWklmS1RTYkU0NUdGbmI1cUJDc3Z5RnlWUHRuQm9E?=
 =?utf-8?B?UWQ1QldaMy9Yc0VEeTlZY2pOR2VqNUViWUZRcEpybmZlSWE4Q0tTSWJHSG1D?=
 =?utf-8?B?ejVjS0hNZVJuK2lUTDViTlMveERxRXF0YmZqTHhxR0NaK2paZncybkJ3Q1h5?=
 =?utf-8?B?dU9EdjNjZjNyVHhLbHYraUo5RzVlcmloU2tOY0dPbU82ZkRhaVZqZGdJYndF?=
 =?utf-8?B?UjR3WWNOL1JTMHgydCtGWWhKZmlGREsrUkJIUU1DbFowUXNyclNPVGRxN3F0?=
 =?utf-8?B?Z2ttY2h3RUpnUUkvTXZCMHQ0emtjb3Z5cFNNYkthczJ1Q0l2d3F6OXBjRkZB?=
 =?utf-8?B?L0k3U1Fuc2FieDhoRmhnbDYvK0RiOXgvWUUweDZCS1QwRFJ3YTdCczE5eU56?=
 =?utf-8?B?UWdHTTBBOWFqVjBwODVBWXhHTzNwRE1XZGhpWHhubSt6KzBLN2I0ZW52VUti?=
 =?utf-8?B?L2ZydFRib2JuWXd4TU1GOU8vN1JPQlBQTTgrcEJ6TEhWVGEvR2NDWmZUNzV2?=
 =?utf-8?B?cUQvaTJPTjZQZ0tFcjdScEVqNkNUMmUyS2FaN0c1M0dPWGNsUGNCdzYxdnJr?=
 =?utf-8?B?M2NWOERwbE13STdVQmxoN2syUUtLb3ZnQThyZXhwdTRlQ0p4SjgrQVZCaitk?=
 =?utf-8?B?VUVoY2MzUkg1WEliZjdiMVdkd1MyUWh3VStENjhJTEhkWVorcUtKYStDYXh6?=
 =?utf-8?B?Vi9tZTEvaDlBOTIzekorTGF1ZUp3K3cvVE5IenBBeUJNRTJrK0kwMi9PZlVD?=
 =?utf-8?B?K1JDU2h2RkhYTmFQeEYyYW4xbHA5TGtSeE9EUGoyTjMvU0hlalJFTUZrZUNE?=
 =?utf-8?Q?4JV2pb7fdnIqpgP4MnQ9RTy0F?=
X-Microsoft-Antispam-Message-Info: IouBAB0QEbmXLNo/QwonpmtnqO012GSBJvCms5lzXbuMMbYLKDIAd6lF2KQZ/oYswfdJc2jkh3u1CO8u9gVIgZIluZ2XxLYbnwnaB+T1NdsQwDrWfzOnf58CMCNyZR2ofwT3i65Cuspi7XOjsph8JRttHRmp08vifJOL/AqnsN/S5Q54YSuaJWXpril/xH1L
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0316;6:ifyTO5NOcVk/hNdrhrNiZ2g/R/6Qk2RjR1R2xhWykT2JBaYST9iRvhQGuh8DL2Z9O0ypWa9cGomxxwoMhGu3Tmx+7bDV3ElQJx4rSsRn34E7KPK5fN3knJciR3wBG/etDIHieBKkGlw7u8JJMYwjphkFoE+JpffyWsuhgFWQ2rPDxRZsI8STz1NDnuTSf7P7Nh48wmESwcD5QlhRQ5s6r0H4d+Vk2rz0a6SHUbMZbKqOPmv+A4CYWvIemhGQoQk6eLlpt2zhUmVcjKjlPDdX3nhrvgp+yAA47n1E/VHnDNheA8pMjyboL3UX9cFGgqwLM2Bvwq5mANJbgd9bGs5aRH14gU9kWu+j4BcIldYsH/imvaFyP6kEm2VB2StAcjMpOM2s3U1/KtKRth2LvUTjxfprZslwhHDEYiUxATxa5Y1hDSDUTNvh2LUGmbXRNnhroi1TCTwZVUlE69Kemyu7ZA==;5:Ykin72yA9yvsv/7PYeBWHOLFDlFyH8QTADRo10hvvMPrnYT8JnJJI8Ys5coqFgtaYfLoNGJYkFpQeh4tB6VOBtRq0H1Kt+0NRDCxqw48mJqwKHOWwE1GmPUPC0UzS2I39LW4hMBK6K6RzkcPO+Lvz5B0eK+WifpinslOs3PWzXI=;24:BWGbPyGiVIr1KYqSW9N9ygzGS/l3W4UyEYLq6+eEDyi9hxuf4wCDQWwhQHoVhoB0X9SHa65N8B4pNogI8SzDi8h/iI4QBPeCM6Zczj8WjfM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0316;7:LDpNiLiHYt5SLpy+CXMpqF7LcJMbeTLXIt90fNJzqlTcigTnc0LOi4fyAifOOkLjbfKYT90+dA34kanZbDgizMUEwHrqpwlTgH3ETacCBzcoTo/N4/c7gZoZr198WacWbV7scV5i+OJMpDixfApS19p+SipvaP7X+5CsWtIX0imhL5D8p2NcoHGZARRQcX0wvRGT2NtbvbUPB5Ufs+VBt8Dpf/Ntaiv4DR65gsTzXdlOQXxmGRS3RMbsEPUPu+ye;20:2+2ckw/g/Lfhhmu6o4i43AmYKv6QXCsrKdJrbNnBHUcMS0Qt0ZG3DvLTqIEjCaAMJIE22gjo+rF3De9eBfkYqf20nT9RP/+wd2g2YQWghWNWaxfUS9Ri8iweQsV+3OGPDpVp7+tx2x/JQxbkJa0Jt1YG5hbHc0Dfu9zkeRg+uacZTFjYIIy2K497udI5NGLblNTy/1a/rUudVIi+eLNA9Bo/l6AW7bXwoZ0fZ+JICoa9s+oiuqgW+utMCqFJHkVG
X-MS-Office365-Filtering-Correlation-Id: 3fd2fd7d-bc9e-47ec-feff-08d5b3e326c0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 06:24:08.8328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd2fd7d-bc9e-47ec-feff-08d5b3e326c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0316
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599296141928589066?=
X-GMAIL-MSGID: =?utf-8?q?1599785408569356978?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Wednesday 02 May 2018 02:19 AM, Vijendar Mukunda wrote:
> Added dma configuration parameters to rtd structure.
> Moved dma configuration parameters initialization to
> hw_params callback.
> Removed hard coding in prepare and trigger callbacks.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
> v1->v2 : Fixed capture stream wrong channel assignment
> 	 added comments in dma trigger api
>   sound/soc/amd/acp-pcm-dma.c | 103 ++++++++++++++++++--------------------------
>   sound/soc/amd/acp.h         |   5 +++
>   2 files changed, 48 insertions(+), 60 deletions(-)

Hi Mark,

In this series, patches 01/10 to 09/10 are good to go from Dan, could 
you please review and merge them.

For 10/10 please let us know your thoughts on it, discussion reference:
https://lkml.org/lkml/2018/5/4/23

Thanks,
Vijendar
