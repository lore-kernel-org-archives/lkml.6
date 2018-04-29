Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753837AbeD2RQa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 13:16:30 -0400
Received: from mail-by2nam01on0043.outbound.protection.outlook.com ([104.47.34.43]:29713
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753546AbeD2RQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 13:16:28 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: Tracking: radeon 0000:00:10.0: ring 0 stalled for more than
 10240msec
To: Mathieu Malaterre <malat@debian.org>,
        Alex Deucher <alexander.deucher@amd.com>
Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CA+7wUszgY3uFVfMe4T-_5x9KuzWNSgKHXcRKgfcmpE+Keo73Vg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <fefee930-1eca-4819-4e02-7ba4a7487dee@amd.com>
Date: Sun, 29 Apr 2018 19:16:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CA+7wUszgY3uFVfMe4T-_5x9KuzWNSgKHXcRKgfcmpE+Keo73Vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR05CA0389.eurprd05.prod.outlook.com
 (2603:10a6:7:94::48) To DM5PR12MB1724.namprd12.prod.outlook.com
 (2603:10b6:3:10f::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1724;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;3:3uF2c1vL4gIDPtLW38qDK1GTpNTj+eUrB0ES7C1bvIl0UaGTqJGHtyiIW5Ra/bxuz0D41TZ4BwIVLhMS8Y1tK8IX3g9bt9kvwuV0yxqrR8LuDfchkOdV4echkF0VCdgtxr75xRraRifNWolXOpYHXtlCxe4ralp3LHtcrH79EZoDtFeooTKMKkhaCQy3sJ/A55hVPygq/77MNODuB/gCsgA42mlq+rqsAy0ZFgY/46eMUB0yTxP3LjguKn8J4Aqv;25:BMahiSzv30qSN9cI/XW4vHPkIEK7pQpoi6jzZjYR5y4XmWssgSqv0jS+zIKEH42E+/6HNIOneOJ5P4LZFUBnKgEw9hrmXg3wJePlf+CE/3RLim1mZkNRCNV4fSb/F/Vv7eB4FY7WzwF3jZ5+aGCBVHECYe0akO9JXe38BifxpjPAGd+L1PCU9727fhqgiZ+G27CkVXgB5tqMi48mIVV0H0enbEJlIc4YXAShEQWVVNBUOg8/YNeaTND+pdWLhY4lgdV/07Eui3qXZC8XR6J5A5qFO/wjd/zwqcnZonaM5hPbz7kF5QFg1BzPYJ1MsEeCqsCxSJUpR50MPQ55wmz7Hg==;31:qiofYOUqAFjDZQdRcy2koY5T0fVlaOo+YBVhCnFTturnhBiLsreNQ8fq8cl10YBKhrOkzfaRIy6KX3gAyO6HatkYnZK0pANdRfR41RsoiTrQm9MaNOzj4durjJEbcLijLOnRxavzApUhpamjGrtJO2NZQeZcz73Kanze2RMAttzAjtTKcaLubQ6hpI6n9EfyRctKuWYS7c0tIVGMTdr1wS/PTV6qmfHC6Wf6BSV3vk0=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1724:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;20:y3Jm4HMCpHZ1OxhA03VGp5InYRrNeN6PGBF6atoe8tNzUtByT9jLbqDuQWRylq5TJAvZ+B95gkst2/QTLgvnXakQAP+u1hlucS3S85Du1Aj8S1NG44ij6V358ADeNBAHy9LVoOOsJKCcgRh8FsQ4jzFC4erSpgdsr1oro8o8nplsihOiCplinuFhX3R8A3BawuYrrFUWWF/HvToejNJ9FbHlAWnnypnZi5VsN7DWvIymikV7x+9wvVr27L2y7XG3hFBUxiSjRvDT37EGeX9JAGn+fNvOqeH/mvJwx8/eIwk+etxBjYgIuSpH//cPOtF5G845ZciCePlmCJdeQerZ2Lo3Vs265AHzKIYNGHPN8VbWBa7lvlfvOk4DJCMZJbHRZfBV/TbuRpB76RuOWQ0pf31CHWnsU6HLUwychcz5Iic+FtnrycOyLJtJysFN2J05YCAXRySyHp6fc7JpbUH472pIYdupzQjLaTfE8LNxKeyJcMCnEUhImQXlKAwkH89C;4:zly86mQTg3K9anbmLz54D8tsfcwfPUslwYvhs6whyKn+qYAyx4b9qGFEBxpX8vyVaU4EwP/LHxSRA0D693c14T5Xuec6C3jCJSchnBdZdFPAz91gdXCIHYtpk1bo4UTr3FBrH2dYA2mZLcNeiT+SVNuXS1HkzTq0ZpdeOquKt/Hs3+OCT4zSxE+u15AJ4qlwSWpW+oDZvFQ2Tmzp7v48Ig5FVIN99i0SAoLElpB5lFK2+rWgBqmzWF22r7NviciOKbTXAlrdJSqDbxe5eXeyFw==
X-Microsoft-Antispam-PRVS: <DM5PR12MB172476314DEBE6D5FE88E65B83830@DM5PR12MB1724.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR12MB1724;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1724;
X-Forefront-PRVS: 0657D528EC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(376002)(39380400002)(189003)(199004)(6666003)(106356001)(110136005)(316002)(76176011)(25786009)(23676004)(6636002)(58126008)(54906003)(68736007)(7736002)(52146003)(31686004)(4326008)(2486003)(305945005)(105586002)(2906002)(6246003)(6486002)(97736004)(72206003)(52116002)(52396003)(478600001)(229853002)(16526019)(11346002)(65806001)(6116002)(86362001)(81166006)(5660300001)(31696002)(2616005)(1706002)(65826007)(53936002)(47776003)(446003)(67846002)(36756003)(386003)(8936002)(8676002)(50466002)(230700001)(64126003)(65956001)(81156014)(476003)(46003)(486006)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1724;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzI0OzIzOmlPeHpqSmwyZ1oybkNRZjlSNVg0Ry9SaWlC?=
 =?utf-8?B?ME13THBLRDU2d0w1TnlsUW9xcUJyazNyMkU4Zm1UTXlpcWdlVU9FS0dQc3Az?=
 =?utf-8?B?VXRmK2JJbGNpSzNNWlhPOHErTmVJSVYvdVFhSkZ1cHYvNVh3bi9pV0oyNmpq?=
 =?utf-8?B?UVRHUDdpbzBxOWxMSmpZdGZaTFp3ZkZxZkJxdnJrSkFvRVM3MFNEUEFUSzV6?=
 =?utf-8?B?a2I4Mk1TbVBuZ2hJcHRmVld3Ukt6OGV4dTBUekRCa2dsNGpha1ZyWDNJL0lB?=
 =?utf-8?B?U012c2tvRUFhb1N2RkJseDRrUTlIaU5sSUc1bGlSMWpXU2ZUcm5qSm4wSnVq?=
 =?utf-8?B?dkVVMnZYZnNlU0VuSzRPUCswZm90Uk1YVkxQMi9RT2RnSVZta3VhdE8waUl5?=
 =?utf-8?B?Q25Vd2pNcUVUQyt0eHR6WUJGRngzcTJDaEpLdnVFNjhDQ3NtLzJrbS83U1F3?=
 =?utf-8?B?dlkrODkreGV5U2g0SDlFaWkvTHNCcW9IMnA4SHJuRlpZNnFBazZiQ1hINXcy?=
 =?utf-8?B?bmNPR3hJc0hOQnc1WHB5VGJPQStKY2FKVzd2MkRBSnB1bThBTHZZcS9WWWxl?=
 =?utf-8?B?N1RqeHN0MDFYK3BlQStXMFg0anIyQmlpNU5HWjVSY2lLZkNMWU1uNkh6QzdT?=
 =?utf-8?B?djBDRXpZbXdjVEdMaU1lcnBmaVEzRmhBL1NpYXl0MmI0ajZDOEl5V0NkU21a?=
 =?utf-8?B?dmxheVVkZ1A5dldtM09IQU51TWR4dDhoMzl0dEJpOEZjTDdmVTVESzFHdVpa?=
 =?utf-8?B?a3d0cTNDMVRKN3hZaVk1WXpFWVhMdldYcGYwckE1YlJtZzNTQSt4UFdKL0VZ?=
 =?utf-8?B?RDFXRURsU2h3TjljR3EzTnZ0K2plRWcraSs0eEM2elpjY0xsM2E2ekVXZTYr?=
 =?utf-8?B?dER1OHRkL1ZkSXU0RXR0UDZVZEtoUlJsUWRZMDRHZTZjVk8wdktxWkFOakRv?=
 =?utf-8?B?NUJnTFJFMndLcjZKWTMzYVA3S3NOWk9LUTI4Lyt5cGxLTmsyeStESENzaGxZ?=
 =?utf-8?B?cHJ0V2V2YVRKY3IyVktFdDlVd1pRODMzbTBVRlVsbHZGTGV5dU5yNndxeGtW?=
 =?utf-8?B?TCtqWXh6Z1FhR0tYYk5TbWpkYmpYNHVueGpxUmIyU1ZoRG1pbE5IMHV0Wlcx?=
 =?utf-8?B?NHA1SFRiVWw5NEtzVmgrdTBQd1AxdC9ycmJqa0ZTZCt3MU54U2NGZDQ0Yzc5?=
 =?utf-8?B?OHlaSW1RT1Y0ZEE0WUwzcXQ4Vzc1TW1CVFloQzVzMk5ISUtSckRQZFl4TUYv?=
 =?utf-8?B?NE84bXkzRUNJNlkzMW4vU1crTWUveVJrS1VkNVNHZlBkTFlSNnpVUzU1RXBF?=
 =?utf-8?B?dUJTQ1N4RUV6RXdtRzI2STUwc3ZIRSs4WVJsU0tpYnl4TG1KelVCQlJSeThj?=
 =?utf-8?B?UVA4VittamRzVzhCVE1uZEtBNDdaMEFBQWgyR1dGUVhQQlpiZXBDZGozbWZ5?=
 =?utf-8?B?cUJFeTNWUUxyRzV5eSt4YlliYVFkZ21WQThzUjc2aFppVkN0Unh3ZVp3eGFl?=
 =?utf-8?B?WXZ3ODdSV05nbzBHTy9lWkFpbEtsWkl3OW90eGJzMGlaSEFpek5lbi9palJz?=
 =?utf-8?B?aFRYNGpkM1NlVkpmQmdtYmdsM3kxQXBpMitzR2VjWk02UTRDR0V0cTBka0gw?=
 =?utf-8?B?OHBLeFNYZkNTYVQxc3FRWWJGRWZPOUo5ME1MR3JJNTFKR0JqK0NRZHRwVU1T?=
 =?utf-8?B?RTdLb0JTNHd2eUF3bXVtVUd2cW4vMm02T1N4OGtnbTgyT1pTYnNtTGw5WEQx?=
 =?utf-8?B?a2tTbWRLN3pVQkJaTHJ6RGczSHBxSWwyQ2loME4wVkIvaVhiZW1JdFNITkhG?=
 =?utf-8?B?K24zWkwyai9FdzJkT1hDbno2c21YWG8wRnhrMkUxa0VNZmxpOFdhdGdzam81?=
 =?utf-8?Q?HnqOGNG/dP4pZo2UtJtKKA8GTXjiZVB0?=
X-Microsoft-Antispam-Message-Info: E7Z6vtUddgU5cDnuIh7jhtv6GGcsKwI8K5OqHqhTyuJv+9SLIf7ABoZr3joG0k6k5v9yxEIsKfwO072xR6OPtzq9cmP13ZZi21ez6C3Z4oD4KLDeQ4JBjwA3HyENVT0QH4eqOBr3Qy6CAJwDI2RnGiTlecD95haGEwQ5ZhiAO5NiqF5XIVIty3B9PeCggpR0
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;6:z3F1gHBLUAFTLSqWl5VLv9gI2yxUS2jftWsacrQORZ/hqhhK1dDNUumJksER9PKVKmr01G69cBveZgimYJi3vYUi0uj5QuHHUe8Bw1VXJEif7HXrSOV54M47TznflWG9TFeAxS6q/6U/LQOHh8iTRU6I6CZGGhS6mIEyboKT336Gqn3NBgYwDGyugF9O1rWSzQFYc+Ezphhmgk+2n0cW9DMS31y8/83JnvHsqaUjhTBkT9gH9IYy0CYFUNvy69Nwm55w8G4BMgH7f7wHce3UBJkUyw4/+l0pJ4bfTWIjyCWlrsGESErYA28dkW/yba/DoWwRDBwTnUgieRoqstFgAPWBjqVo2JZC/zzheGTF7RWXaLZwD3mpwJggCoE4OSc2xNqrc4aKoTGCF1k4b4g8tZBpt8hYTt4jlnYHxDIT31qpXGULLNlhdByRmU2VbCj3CqF0BEhMktkXhmFnNei7TA==;5:kyHV1Hk02DhjD63EnsXi0OvtaVXKmO8O/UTOG5KZt6qu3swQg3jW/nVHyHZ073/hPjFi/Sn5yxj2zHC5PUYSpO81Yl9g/LMX+Fo4JGTxN85zBJZwsO2QETSV3mKSpNbwFhgur4zrAlPKUgCA3GC/M9mu1JAkErphnz0aQCkxGak=;24:Ukh/IvXcqPywm4v0HvuMYCoCc69g4/9DxkRC9RYQUHQuf5uP7tqqYJJDvIF7NLmn3J2iw/t3yOqPOa7jj2V7apN5TS3cA7kNWrDRY8XYlnQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;7:2SUlkRSgvuFlt7SzdUTtVjemSl65DEUiOKhixWON4uMqoXg555agbxO95IVSSF+xzl3DfQH1Ajus9GX89qEmYQlNUxbPSZo+3gAts+YdNF5+J72j/vK7QaThiCY6ZTuX++t436fzA5/1NTjbGT7ibRrJumYI9ul9hjdao9AhrYqa8H3dHy8OdRPNbhIBq5+llSnloSKptN5I61ZnP5vjXQNiCLznRpNk7bWMfv61aMtOq40wzzA0ls1lLU5nX3uw;20:Gz/yWQFIeJ+SsdglQHRc4R5B21JfBjwSwJQwwmLz3V099ilfr4Me0YrarOvSyzsddWY8nruFhIbCD+kHR4knC3vFx9J6rEGRW0VH6ZSriyyeIH1TTJYjvFYCo59fevCun3J1t9+Na36D3Cg0aM0F1JQ2zWv8GXDWhPV6mLDqU/OSU5xOCeLSSe3SKI76rgyufwIQUfu+GekoJVk6NDd6Iho9Adv9tn1ZmY5GcrXkJeMqlxzDYnD70X4lL4653Nac
X-MS-Office365-Filtering-Correlation-Id: d1ec982d-002a-4516-5a9c-08d5adf4f080
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2018 17:16:24.3167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ec982d-002a-4516-5a9c-08d5adf4f080
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1724
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.04.2018 um 20:50 schrieb Mathieu Malaterre:
> Hi there,
>
> I am pretty sure I was able to run kodi on an old Mac Mini G4 (big
> endian) with AMD RV280. Today it is failing to start with:

Well, that is rather old hardware. I suggest to make sure first that the 
hw isn't broken in some way.

> How should I go and debug this (other than plain git-bisect) ?

You first need to figure out what's the failing component. Either Mesa, 
DDX or the Kernel are possible candidates.

Another possibility is that you updated kodi and kodi is now doing 
something the hw doesn't like.

Regards,
Christian.
