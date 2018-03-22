Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeCVFw6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 01:52:58 -0400
Received: from mail-bn3nam01on0077.outbound.protection.outlook.com ([104.47.33.77]:42112
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751948AbeCVFwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 01:52:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com;
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
To: Mark Brown <broonie@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20180321133040.6754c372@canb.auug.org.au>
 <20180321024556.GX2186@sirena.org.uk>
 <3bc6e9ca-b1d9-3458-6399-758be07fd7f3@amd.com>
 <20180322013817.GY2186@sirena.org.uk>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <3d47f2cb-0a73-98a7-bb3a-f40baf00123b@amd.com>
Date: Thu, 22 Mar 2018 11:24:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322013817.GY2186@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: BM1PR0101CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::31) To CY4PR12MB1670.namprd12.prod.outlook.com
 (2603:10b6:910:11::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d5128e7-e9db-4398-b59f-08d58fb925c7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1670;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1670;3:aVxSLCDkLoPrkCZomnwek3oP8mjurl1Tr4K4WbDoxycDAc4CWtdKD+w5ZqIVlerm1MtsD8DyIjPj9PevFsEhxGt98ysfMiFNaNJHsjbMzxwTkgZSiglWG+g0U41x+Zu9uEmR57wtohY4EZ78nX0pAHyXRG9xKDhvs80ZfMfuWc/64Afs0Rt9OcxEPyJDu6D5Lv9aWWSz1f8PVE22RomiLnZTJ7eu2DsZATjOM8Bgr9/R1kSYbqvOCs9tJOGcMk/X;25:DcazXRuIxigoRvGGxZeDfDcqFD8ekZXc5WEJAgBy1U98FMNbP4qgD4zW4ZlzUIk9YxWydNa7IdTI1i0Pr4rSGYbJGZ8BmW/Kmp1kGJ4176GYLHHO/IFddgGE67eWH0I79CPq84NcqtnwEWxPnaK+2W1uzHmKXshu2yV2TAFkwIT0v5wvOhXabb5DowQ/CzjGj4ymO3pMV3LPBakomfGq1iiplI8pgxV78bpw0Q7Jbi1NFj0meylI1A6ELI2KiNxKBSmLN9mX12TDSLeAhFKXIXsjzeTru2bJcLnQWuAjFhizQHrGCCD64SKQfXhiw0fycx/HcgFMdkZ8o86dOxup7g==;31:8F8LAGcBDqUB82NqFWoNJSREySsTjzK805MTYXCGTIrI05jLnJU3XS6VGLXcU1tbkK7mtY6/p8QiP9nWkMPfMc9raCbotF4xu9eJhIZV481794EOzw93l9O+jTbpuYGkA9DERpRTpJFFXcYUE3uXgRxX4V0Tgpb+Wd571dvNgvezFW2je18NoSMMpT/RmPLXumc3tA5NgHkpP45C/VhuWbBHxhAU7hSBW4XA/elL1pU=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1670:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1670;20:aHgypfozD/Xv75dmbmcqBcXsASfsp7RxzyvRF1oWTlEnkDoHctELC+n40jWoRQyAxKhkQEjtKzKWMwtt/Au2q23/56hjZqC9qGEBHafS1ZjpFr7KYLo/mJUoNDVGET0aq/JRpyfxedkXx/6qcGRb1RvL4cQKw6ipb+4mAgoz5yI9oiAjY+xAlA7RwQUiUOiRrrEogHYYRMmS/PqUW0R1VMgh0c31xs57m9DzvyvABZ4gTinoI6nKq2wudoFghE8QfUoia7LLRTEZYSHkXe4/kYVDmbQVSOliYNnESSZZ7Xfr2QNg1B8noAmXArE8johrnFvFyc7UiGRXinpecCBfA43ESGm3Esi1QK0v4YY+VlGzwB4LQjAhMzY/I9Q5odaxqQLpzuYZkcURGI+bbu7EOcR63AVJIi9yx7oala73yiz9g/4Gb3NMS61uLIbYqSJerMvRnDivXqN442OFy4nPUGA0oDnNzf3jslF3rx3IyCRVjT+/rFrUTWmQYkqC8a1C;4:RGP9JvwL8ZMrpMAFq+ECwpZTq0PPBqGp5qB/WxMysvwgZ0bR3eOGmw3haJbfWFqjDo74C6Cz8TVs3oYoRByJuGOe5m60wxRUWAcbeta8oYL+cj9JPtqaqpFugqGYNLfPozKTQLjMsKLnZKrZOeC2Yw4z584rhfUcERiU07K06/1N7i3gPQv+gKJSGG5sLqVHN6EE2yAbhy2Atga+zcVKtvdtGPNerbZMGQ2mR76TRMb6vt23dqtpf/ZlfVQOXlqAq0w+tHwsuGLpXtZXM9aOwQ==
X-Microsoft-Antispam-PRVS: <CY4PR12MB167063CA94BF38B783C2929497A90@CY4PR12MB1670.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR12MB1670;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1670;
X-Forefront-PRVS: 0619D53754
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(366004)(39380400002)(396003)(376002)(39860400002)(189003)(199004)(2906002)(6246003)(6486002)(5660300001)(229853002)(8936002)(67846002)(53936002)(76176011)(52116002)(50466002)(7736002)(77096007)(966005)(305945005)(36756003)(65826007)(31686004)(446003)(316002)(58126008)(81156014)(81166006)(8676002)(478600001)(25786009)(97736004)(31696002)(68736007)(106356001)(23746002)(72206003)(86362001)(54906003)(105586002)(6666003)(66066001)(2950100002)(386003)(6916009)(65956001)(93886005)(4326008)(65806001)(16526019)(26005)(16576012)(6306002)(3846002)(2870700001)(39060400002)(6116002)(47776003)(64126003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1670;H:[10.129.12.246];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY4PR12MB1670;23:8mRU9npchG74lLP28ByUR3ySWbtwSCjEFiG42?=
 =?Windows-1252?Q?b8DWwknW8t/pzwFInfHJClEEV5U5o0Daz6giUhDw59qc/mUwYIzeoXgV?=
 =?Windows-1252?Q?HzBN/fdTqDAg3NlZvIlmvMjY0wjek1/oel620EjDGrq2cQz2TJFTxqEb?=
 =?Windows-1252?Q?7rWJQfOLMSU2zyuofcEd7FkMS0PaksQe14jsw3Qtq8C7NrarWPKJdriB?=
 =?Windows-1252?Q?JMHOgyAiCq20eHWPV61bmHWz/QEEEsASOBZxROrVjrapGuOO4TYkRv6u?=
 =?Windows-1252?Q?kVAPNHf7X7PwhrfERsU0Q1/Efjzi9nW9i36oKsdCI0/E3q3IuI8Y5GsW?=
 =?Windows-1252?Q?MS2/6xtx3GizeGJDrIrH7k7quaW9sd2R4GTG2r+S149PAKGnElospDA8?=
 =?Windows-1252?Q?R3u08wnAxoOCs9ewKkLJ0DWjhvKOMa/0UVwUMOIQ3RPpp8Zn/JOBp8hL?=
 =?Windows-1252?Q?XQY5/nvX1sQEmQUxEE87mRDCp8mo7J+HJSw4uYbKh5fEpwHTfbHAjheg?=
 =?Windows-1252?Q?DQgm4i097sRvicl5fQ9sOp/6AdjNSpHcI2ZweviVJ2y/HRWNeI52+WX4?=
 =?Windows-1252?Q?xo1axg3ZlD69Are2RWUfOaIO2ZRCW/ahmXmBQCkdkIZONghIXMr2400R?=
 =?Windows-1252?Q?RrLZaFCUP4dW9pj8kOMiHeF7sLE7iW+ltcfDeSJTWvGorCUUeQhnQ18/?=
 =?Windows-1252?Q?6AecPR+t/pYmzYL/Kwkgb1idU/IeLHQ7fDIjpSdwJF3Wu6MqIIY7lBr4?=
 =?Windows-1252?Q?p0advKSO4oHdsc+9NR4YHX9jHyo5P9v+biSpyRoiiVaLcTcjPUi67t6V?=
 =?Windows-1252?Q?2uKcYINC3mUwIhuT0TtVjRM8/TCatnkeWdKhsPHnmdjquD4dXeMUiUq4?=
 =?Windows-1252?Q?kjYjdOSznY8mWN64lORHhhXP/SWKj/8smnLI7hwHoPbz1qoyUIylYRh5?=
 =?Windows-1252?Q?X9T1F3P6AkaytGdCoW+2z5kqy06JYJ/1fVoKZG8E+p+KpgturondD7FD?=
 =?Windows-1252?Q?dIAxGFkwLe7KWEIG4SvHE44XPbDcmc1atQPb7/vSrS6af7l5GBprS+bS?=
 =?Windows-1252?Q?Rcs9KPbViYBxYK2nioci/dlYy7OHmyFUwcIqVQy03iIT34XN42UbvkQN?=
 =?Windows-1252?Q?cendd/Uy/6gI8uika5VjJHK3u+438VMgbD2yJL8xAJsjhtoXNj8r2ZAG?=
 =?Windows-1252?Q?m8BgFCU7NsRThZcF7wez2gXMq8dgsPsYaIw4ug3s/f3dI2miyvJ/jicl?=
 =?Windows-1252?Q?NhR1UPzS9azUiME4bzfIK2+ag+5QwhfIGnEFQtgQaqoUXuWJJ6y2VCvz?=
 =?Windows-1252?Q?IqHW4qh2q3E64Qe59JQldqL/Br1jaALvKLHGNRBlzvo0U/mV0OLp945s?=
 =?Windows-1252?Q?MF/KGPO7hnDMYWW+ZLPRaveuqjdVwRPtUS/+HuisphSaKOFcfFReQ636?=
 =?Windows-1252?Q?gQFx2PytAW8n4tLCm6NJMBI9AQDrUCimH1BXo1nlshknTmho4wPT80IM?=
 =?Windows-1252?Q?BFRg0GeG6b9uXltilyB50gNvDsehy1Gj/e5P6cUQXkTJWVvVQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: INt/hSpYFVILqiFqmN/TSev54YQayQrrU2M/brd5CfNvuyK5ns3r/4LLw+fqhKNytVEsvPEMRSsrYY+kAYbDzcEgy/7HyZUnX558pqyIZFV2VgvJM1CTWz7pJs3K/tCwVXLB22ZCOOcWUWxCG0oBmkyPyo5qIPFVNJlxfj5o+Bi5LaUJF9cJBNls9kGNsJnJ
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1670;6:gEGw1gZvetSrTxdypEdytRyqisc9QfK5NUtDyWz/xUvIBTwnDR9zHQs2ybdZJE4k6aBYIxKDYJqPsdEqQTgPJgGBn1elfatBo51dOQFv6EtocoryVXFJmrtA+A9qP4QUHZdFok5BvJ6qtQdKj4ApRt8rSh6jkqP+8lt9Yuxz9bTuhcgIKh8w6knSoUwQmusPdXpnsHeZ0McjFfCjcn26uDcQcxG2jnmrrZG9vUnu3JwAcM68EATfnBjzSRocKB6NHtO3CJEu+FCUeX7Qb9CYBsSoBb/I+JReE4Aq35lTQjeHEGS3CoWCpWc/+AzQWTPbiebOgHYFmwmulUMJTOrfHSyaDoBYbLVl3Hm8t0MjkcA=;5:SOGlmXQaQ276Nawnrb02VhvNT+3MfqO0F6aUSig3J/49IDV9P/jz0mrLhShvuIbDGvr/I+84mYwTggRb2HPMDa5CTl9RWLbNqYiKP5YcJs1ft2vWdGLPBYFKLvIY0Fjg8MdoJV08y0yHUWES5feO/+vSabTxUlgWetmj6xnTp1o=;24:Sii5dyuKtNEIY/xmsVHqag2Ur1Ko2/KIlPiVhYpnsBKrcQXy1WrSn/87AZ+i+tqKKbrtallRR6/rL8hqR3IDsZ3nU2IUqHKlYZAMZHvUzSU=;7:WWAf9PMws8pr5N3T0xRzcUbFXsYXSdD5lW4PxXeF+l718X1HJw2ZHLveWOjPiv8HK7dwWnOWLrMQwkh4Ffbv/GNS3JtofaxcaawhFDAB67QdCnmZtnhSQaQiWNTYrS2MH47g3RMqFeYkjOsXiT5FJ7pMO/Tnpqa7a4s4HZM5Sw2mq6Uf6He0IR3dVFLriOpJPZpjZRRRt+vSAlwmSCuIFkR02YiM8+0o+wjRiUH14lR6kxML/LcsBA7FfgBB4lQ1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1670;20:6EqPddaJNmzGVW3IhFp05rma8Biqs6acknqAA4/HwoMIJ2ZkfkYxgVkR/vXYUisfkNPmAXaGGkZRSWlbs4j2/H/Xe8dBAY+X4HLU4w7FX2lkTdJy9dsDsaIpv/MX40LhXx4l1hZCrNS/KXF44YXXTBDG7eEzhPhXRv+o+E8CYs0xYRYnr2weURV257GaEyttPQ+uEXPSkDp9DsBwAf+9s6u4Zk/pbM7tNiWU6mfNtZsQMuREhjirXRkEzKK9Gypc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 05:52:48.3516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5128e7-e9db-4398-b59f-08d58fb925c7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1670
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 22 March 2018 07:08 AM, Mark Brown wrote:
> On Wed, Mar 21, 2018 at 11:15:16AM +0530, Mukunda,Vijendar wrote:
>
>> There is a patch dependency .
>> Below patch not merged yet. We submitted for upstream review.
>> [PATCH V2] ASoC: dwc: I2S Controller instance param added
> You need to mention dependencies between patches when publishing and I
> don't seem to have a copy of that patch, according to the list archives
> Alex asked you to make some chnages to it.

    Changes suggested by Alex already implemented and posted .
    Current patch (https://patchwork.kernel.org/patch/10298281/ ) is
    dependent on below patch.

    https://patchwork.kernel.org/patch/10296597/

    We will publish patch dependencies while sending patches.
