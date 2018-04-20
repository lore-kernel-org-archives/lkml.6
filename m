Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeDTTkb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 15:40:31 -0400
Received: from mail-sn1nam01on0040.outbound.protection.outlook.com ([104.47.32.40]:24480
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751336AbeDTTk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 15:40:27 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com;
Subject: Re: AMD graphics performance regression in 4.15 and later
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Gabriel C <nix.or.die@gmail.com>, Philip Yang <Philip.Yang@amd.com>
Cc: Jean-Marc Valin <jmvalin@mozilla.com>, Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
        alexander.deucher@amd.com, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com>
 <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
 <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com>
 <312ed341-7052-a61e-331f-d1e8fd5b477e@mozilla.com>
 <d136f940-d807-d2f7-30a7-8617f130912d@amd.com>
 <77866d66-2728-8295-d7ee-9975dbf64b99@mozilla.com>
 <55e1712b-6567-50c5-3789-53dd1ccddb94@gmail.com>
 <CAEJqkgiOR3aCGoNquVeEyC1BLMBPmXNjgrmjNeeE9UVfzcJKzg@mail.gmail.com>
 <dafca4cc-c7ca-a06d-3a17-46240b1d20c3@amd.com>
 <2a864040-3888-c30a-2fab-6ff637dddda4@daenzer.net>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <35c599a3-0042-4f00-52e4-9d17164b93b1@amd.com>
Date: Fri, 20 Apr 2018 15:40:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2a864040-3888-c30a-2fab-6ff637dddda4@daenzer.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQBPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::37) To DM5PR12MB1707.namprd12.prod.outlook.com
 (2603:10b6:3:10f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1707;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1707;3:K88xQScIF/f45hrwiHnr24IQsk7M17rb28lrr0YUPWm7dBtephtCn2jdC0KJR1q8vxnm7m4o+TJC65h0fznifKKKrFzkw/zCEEFLoQOFkL+FV3yvOmMGCjGe4K7fj2VHlDD66TtEtFHlzmsJSjQV1wtTZdmyzshKGyMRQBCxpryGxktDZY+fFnFbfdjXn8xWx3MALm8Qn9cva7Lb5zTsjSLi544Ln4bkvdRin4znWk3Edvtu91nqu1a+SjyTveIw;25:luqbznTnTI4VzBpTGfzIKT7HvB9MMoMYeLV+e6TgJ3JqKYdN6Uv2iw6wc6IE9L0Gau01tyDDYNbdtSvFNhqrl25Gze1DYmjJuvVi0IGGET1Ijn6+gcK7cxadpAtJdd6Q5vANx0ChkYOTpcs9xyuNZryQGRdxjN2bvaMfMoRbfmO/U9N6gjmVQZRrGUF5he8+mnghfTmW/cCIuZW1lImF+CO42v37TzaXH9V1/SvQt9p/tSUmwimZkssA08XJuGARBCXaT6JYlHm4joGjGAALHvvun/T9gepUUk1+O6wXZPb9zNxHCc7LobpMKNiuwvm3mP6r5OMBmmqjQe+gRuQpqQ==;31:zU0R58gg3QUoNLS0x/rp1bH50iMD8lHPpc3575RF/N/jhNTr4fiyYUD3PwPWobVV661sVFxCsUfikBhDbbNF3gkJjkmVIzQpWiECn+KVaXXh8U3jiPFIHX4yLhC+d7ItGPsndHvKXbq7N/EkkoN1s3OP5UcdzIyJIYClzpEa9Ai7e06Aqt1SjHIVQRjYrcwVWkCPk1EI9T0D1l+fSxlMbrAeyIR2+MlJCmbxF+qDFyc=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1707:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1707;20:nPC/Z3sncVZVjcDIZUT2Eof1as/D4QRXa6oZArM2bDQJBM3kjFIGS4tg2Z/FsXtqnfoRlg98bT2Icc31JPUQ67LdbxF0rZRkuAAJ82BNkD5UNV6hGhjruqctHvl4XlMR+VbO4jO28RA+6d14OEJWhIDaOMcRJGHJvNKVru/vsO06IbXJ3OycgxNJcplOlsVbBdqaKXyg38m63lXHfywl9wAcQsnuG3xkC5Hn5MSsjuvXSssYUVcTPxKGiEvit6k2Ko6fDtHYhqLtZtyCuGipd9kEmlb0eHSpLeXJHV9Voc6ohnYdBchmTE2lzL1VxdaVJ9U+zG35/CEggduAgy7P5zTwPGeVRLy1xLTAFkZK9XwEJFtwghP3lt9ewrLXY/KhrCB+p121Z/6eoR0jyu727+mSGZvoFGXGi3MyfLzrup8ku7fXUfAnEmGfGS8CQIa5GT8vTivnxwILXwmuMc3NMybFAi8nn/3GZHFVjKnlpFMhKrz1AqHvBSd2EDulHzJX;4:mOZd0UJlHjNG5sPbqY5jzl8l0eJlORThMnY1ePdVMqGRX7ACMgodAnaxd3DXB/nUF/EYhB2OAU+ducQsNDP+0rI/LRbqsUNWD1UP+XDcoGuKrNbcvvnhbp1nv75vx5RAW+uQgYqzkgVQ1ToHFNwkRQCqFqVGNlPaa23g+e5m/L4LFlgLbJBE4svzQqBataB0Gr+gIATeRSGxbfRyEcf5LVx6vVR6GnGdkp3SVtsUQbuHoOv0oqpuoRByqGK5JRhAG5OtyJQOsdUWPFX7rcuh02vnVShTZIafARD1tKhFNQPxyjTbzxmWpYDMN26Ukhx8jyQKIKEzg/cXugNhuWf7QPl8q1/rVcPZN0x2AO4e4Ii6BLC6tX57dbgUqMViNsX6
X-Microsoft-Antispam-PRVS: <DM5PR12MB17079181E3BAEC21BF4647B992B40@DM5PR12MB1707.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(126947320029983)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501397)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1707;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1707;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(376002)(346002)(366004)(39380400002)(39860400002)(377424004)(69234005)(51914003)(93886005)(25786009)(6636002)(229853002)(6666003)(476003)(53936002)(16526019)(59450400001)(36916002)(6246003)(956004)(4326008)(478600001)(2906002)(39060400002)(50466002)(36756003)(23676004)(7736002)(16576012)(316002)(44832011)(2616005)(6306002)(52146003)(6486002)(26005)(305945005)(110136005)(65956001)(66066001)(77096007)(65806001)(64126003)(58126008)(186003)(31696002)(54906003)(2486003)(8676002)(575784001)(76176011)(11346002)(966005)(2870700001)(47776003)(65826007)(81166006)(52116002)(446003)(5660300001)(53546011)(386003)(3846002)(31686004)(86362001)(6116002)(72206003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1707;H:[172.27.225.16];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzA3OzIzOjdlZkVKbEdJSlZVV0MrWks0bXhzYnlDK1dQ?=
 =?utf-8?B?anFDVXlEaFdvdTNPb2tyV0tUWUtVYTBNK1JTK2Y4dEpUdXVhL1IxSVdWZlJh?=
 =?utf-8?B?NHBsZHl1Q2JrZEtoNHA2d3J2ZmtUVitBUnNIRlQrd2I3UU5PZWJteEFYUHlq?=
 =?utf-8?B?cmVyTUNJY1AyRGlyZm5SVG1pcjc5RU45NzRqMHphazR4RDlraEdyRlhraVM4?=
 =?utf-8?B?a21KVmxMTFBsYTlyOCt6RVYwZFZIMDNjYXFSM2t4a05qaFZyZmY3anVYOXlw?=
 =?utf-8?B?cWlzVTZrNFR0Rm9pMzErSDVEeGtjTithdFNoei8zSEpHam1xamRCY0d5TW4v?=
 =?utf-8?B?M2tnbFVVeE5tSXd3U0J2RExCSjRHTVhJUi9pdS9OV1ozOFJwQTV2VmNQWEtq?=
 =?utf-8?B?STlRbE5VWElnYUZBYkI2L2tQbWM0eVI5ZDZnMWJhWjdZa3V4ek9DRWt0Qnh5?=
 =?utf-8?B?czdyU2dmVE1FaGV1ODlrRnd3WG1hWGs5VHJ6S1ZyQTdOZnBQOXNYc2VJUXd0?=
 =?utf-8?B?ZGx4T1drL2N0TTBxNkxnblNRMmNLSzBHS1BZSG12cmk3K2lacUl0S2xlYlJG?=
 =?utf-8?B?Z1ZpTit1TFRaa2ZTTmw3R2RiLzdTYTZDMlY3OWl1S2tsdU01UUlzN3I1YXMw?=
 =?utf-8?B?ejk5eG9PQjVpOHFvY21nWVN0Vi9QaDFEc3VWRjN2K3JTNUhhU0dXdzdUbVRP?=
 =?utf-8?B?V1NranhMdWdoUHE1VmUvci9CRFhuOGhST1FMRDJQS29ydHllMGRuM1ptMDk3?=
 =?utf-8?B?c2J6QXVTMDZWV0dCemNENVRBbTNIMVRpc1VubXJSa3pKZEI2REtFVlRScmJV?=
 =?utf-8?B?dHBzNTUwcG52Mk5vUUZTcEQvdWRsQTg1ZXNiSk94ZXRuTnpiejgwcjlGb2ph?=
 =?utf-8?B?VlZsWEZCeUYvU1BlOCtkVU9YT09kSi9Id0VSeXExcFhrSnBCYytLTnZ0ZVhr?=
 =?utf-8?B?QjM4d0VLRzN3UGpIQnY2bWdrNWZ6UHVRb2w4dGdFeEdkUXhGZEZzT0Q4eGY3?=
 =?utf-8?B?czY2em84Uk1kQmhYaitnSk1LU3g3cUJBYmcralBYRWJiN3k3TXVKTElmK01w?=
 =?utf-8?B?NWVEa0JyWG5YNm8rK1BHSFQzVlNMaGdrWmNhdDVhSVpSWDVXOWJjL2F1M0pu?=
 =?utf-8?B?dzkyZFN3MDZ1MVhRTyt4Qk9nbDJkZ3c1SDM1MGZJRzFmRTFCSDFyRkhjQkx3?=
 =?utf-8?B?Z3dLZ0ZkcU1ZZU1wRE1EcFVJYnltdm1VRGNvaTFPYy9vd3dCMDJWcmVtdUEr?=
 =?utf-8?B?bkd3NkRFblBxTEJIbEJIdTBocmlkZUZDdTJ1b3NtU3NrNlAwNHhyZk5CamJY?=
 =?utf-8?B?aUlVTnM0Wm4xcTY0eU9VMWMrS3RldFY2ZXZQZ0dpaWdURlVoaFQ3UGFtR3la?=
 =?utf-8?B?RVphQUZHT05KYXVuMW1WNkowVkNYM09MK1E1Y0hHQlo0TUxlUCtzcDFaMnJj?=
 =?utf-8?B?OEJlVHhtWVNDdnJYTDZvcjVUZGlBdHFSVWt2djN2YUJYMnlDNlZuYXQ1b0ZI?=
 =?utf-8?B?NXl0OHI3WEQ5SlRZdHI3UlVJQ3c4bTg2K05WRTlrK1pYNG1UeHdldkMydTNY?=
 =?utf-8?B?dDZ6UFpvUFFmZi8xMU4wMXM3KzlwUGgvcWtQd2gzOWZkYjRMcDIwUCtpTlhj?=
 =?utf-8?B?YmFiM3A1bUlWdEhKY0NjWFVUWndxZldQYW45Z3lJTjcxMG1jamtDbFJRYTJ1?=
 =?utf-8?B?K1BORTBPblFRaU56STlaZGsxYUVyZnF4RWw0U0R1alJNUlQxUHN5TE1IY0cz?=
 =?utf-8?B?SVdPM2JqZmE2K0M0LzFzRjgrTFpIazBBOWFqQXJFaVcwSWFEM1B5bXZLNTJk?=
 =?utf-8?B?c3MxY0MzWnVEK2FlUkQ2cUhuakdaT2gxNzN6cXZSdDE0VURWdUk3SXRSMit4?=
 =?utf-8?B?bE1xeCtLZVdaaUdPSTJwenZrbWZ3M1BtcXFVZVNsYldGNlFoU0VwSnN5S1BR?=
 =?utf-8?B?ZnRCMkdTVE43eUl1WFcxaTZldnVvR0JybmFFd0hrTVJ2LzNFOTFzTlhWMCtZ?=
 =?utf-8?B?N1RCV2YzR0s2WCtkWXBJM2NWcGl6Rm9yVWRSNnNvaUNOSEl2eE1PNHFPdHJo?=
 =?utf-8?B?Tm9nYmZ4ZHRnMFFpUkcrKzJZMUVPSm8ySFNVUFhKQTQvQ21RR2ZBOVY4Uyt1?=
 =?utf-8?Q?JRWl8QJFYHVBHr6VqNXogYk=3D?=
X-Microsoft-Antispam-Message-Info: RvS0Ay9pMIQwvOovd1A2A0iZFbqAsWw5tJlBzEu0p8B4rNSdJVqu0I3hvmtSB24Zr3vM3BXkpQlFpifEyV/2ZXuh3R0rrf6YMTxH2XHT8fqYNq5GyzbeVbi008cevrc6oByUwt8jYbQDM5axYJnLU2aMJLLNUEXpc6rlaLVIGGbliY5A5DsSxiphRLy4kjZX
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1707;6:iHivruy1VDu85g57tk8H1xEiCqEdgH40WFbkokGPLY6ElQLufTbQpOfttjEmEsjeCBrJrOQbA8b3sMSW689qFvqSmvZ3DRcBqrgqRvOrKKjTPMs9Kfjy4UD8z67V/KhAT+uzNp/RU6mfp1pnp4q0RKsS2Vz8pabLt/PIstYnFdkd6CgRS4Iou/P/G8AGbawOYI8XIRFaZ6U+TxL6m0T8IJuhwHAGrNMiGqgdBgZ9Nj8KmBFD6bhnEHHT7EKUCxnRzIWU5ZKeocQvUBqlZAKZLF9J+9wsKho8tyc09l9pqC46R8dZ4KN77gaB85ikcNtPDuXGR7LOdOhgsBWVPVNi43XV2FB7K3KEYqB1ThOg1r4PAnaPf5n9XDMwaGsZigDVNfMHc/UHqpKvyWN42U4VBiKFIjIhGoWgC2WyREK+eXX9d3U1fir5EaRNhBttaN23vbscYjL/lkCoe6dQYwQcRw==;5:tOaMumbVfMpYLGTtrqvaaLErI2o8L0LY3Q5mqADQXeHB44R5Xbr3O+AEgodekWUe8f1Qpymkm1SIvv6HPTb/GRHf9RGTaO3GwFMmgQIF08bce1DyXYpwGEnrQq9hb3uMLDKzcO5+lLBZIdwj3N1b/xrAtSLX2Aleh1e098LJ6jE=;24:OukYwl3oMpnOP52a/k5JR46m9ipi3GconvrK76d/glfRF+4VDtruRG/fZUjQfbSf5MC9nI3H604zpeMhUTGTY4Ms+aODoTqlb8p58Pb7cDo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1707;7:PN6F3sNbu7j4OkO80a5WXNuHSl+/wgMLPc9ovwA0EtsUK3U3DKuBO8xePB4qY/ZyiXU9cth50lf7WQ7Fw4VrUvKhUllXwIrxmph8TDONGiRIaFyKU5Sz8LoG2bNGVo97swduvjBjVk1MGFj/RZ/51bBBAHRG2P4oJoV1Nai2xzXLb7AF95X6HnOzBGnoKUBAvdYXpb2FYBBKZ6MTjWiNZdkVYhPwFh6ikI0yQKoJcIl+fEO0syFgtxfptsHSOEd6;20:BGiZmTtInm1TnYgu/0Wc4EJ2iwzybY+0fhRC8klIxG3FrBiq0YEkdrOpsg/oItV3PFvMDHkoKMvEsyNP6jieTW+GfxroppuFbGuFm6GXldFl1L1ty99L01JgAEmCoIn3YzNcQivHPIWCao9pXqpxNPO8tyEaEcz1bt116jMIrc9DQbJ4fExBbjN4/VIqla19HsVW8uSbW1A7sSYSEGjGuB2+Tba7xXasIYg+pypmQcxY10E1aAvEhS9HT8kXByH0
X-MS-Office365-Filtering-Correlation-Id: 4a27eda8-38e4-412b-3414-08d5a6f69073
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 19:40:25.0927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a27eda8-38e4-412b-3414-08d5a6f69073
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1707
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Philip]

On 2018-04-20 10:47 AM, Michel Dänzer wrote:
> On 2018-04-11 11:37 AM, Christian König wrote:
>> Am 11.04.2018 um 06:00 schrieb Gabriel C:
>>> 2018-04-09 11:42 GMT+02:00 Christian König
>>> <ckoenig.leichtzumerken@gmail.com>:
>>>> Am 07.04.2018 um 00:00 schrieb Jean-Marc Valin:
>>>>> Hi Christian,
>>>>>
>>>>> Thanks for the info. FYI, I've also opened a Firefox bug for that at:
>>>>> https://bugzilla.mozilla.org/show_bug.cgi?id=1448778
>>>>> Feel free to comment since you have a better understanding of what's
>>>>> going on.
>>>>>
>>>>> One last question: right now I'm running 4.15.0 with the "offending"
>>>>> patch reverted. Is that safe to run or are there possible bad
>>>>> interactions with other changes.
>>>> That should work without problems.
>>>>
>>>> But I just had another idea as well, if you want you could still test
>>>> the
>>>> new code path which will be using in 4.17.
>>>>
>>> While Firefox may do some strange things is not about only Firefox.
>>>
>>> With your patches my EPYC box is unusable with  4.15++ kernels.
>>> The whole Desktop is acting weird.  This one is using
>>> an Cape Verde PRO [Radeon HD 7750/8740 / R7 250E] GPU.
>>>
>>> Box is  2 * EPYC 7281 with 128 GB ECC RAM
>>>
>>> Also a 14C Xeon box with a HD7700 is broken same way.
>> The hardware is irrelevant for this. We need to know what software stack
>> you use on top of it.
>>
>> E.g. desktop environment/Mesa and DDX version etc...
>>
>>> Everything breaks in X .. scrolling , moving windows , flickering etc.
>>>
>>>
>>> reverting f4c809914a7c3e4a59cf543da6c2a15d0f75ee38 and
>>> 648bc3574716400acc06f99915815f80d9563783
>>> from an 4.15 kernel makes things work again.
>>>
>>>
>>>> Backporting all the detection logic is to invasive, but you could
>>>> just go
>>>> into drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c and forcefull use the other
>>>> code path.
>>>>
>>>> Just look out for "#ifdef CONFIG_SWIOTLB" checks and disable those.
>>>>
>>> Well you really can't be serious about these suggestions ? Are you ?
>>>
>>> Telling peoples to #if 0 random code is not a solution.
>> That is for testing and not a permanent solution.
>>
>>> You broke existsing working userland with your patches and at least
>>> please fix that for 4.16.
>>>
>>> I can help testing code for 4.17/++ if you wish but that is
>>> *different* storry.
>> Please test Alex's amd-staging-drm-next branch from
>> git://people.freedesktop.org/~agd5f/linux.
> I think we're still missing something here.
>
> I'm currently running 4.16.2 + the DRM subsystem changes which are going
> into 4.17 (so I have the changes Christian is referring to) with a
> Kaveri APU, and I'm seeing similar symptoms as described by Jean-Marc.
> Some observations:
>
> Firefox, Thunderbird, or worst, gnome-shell, can freeze for up to on the
> order of a minute, during which the kernel is spending most of one
> core's cycles inside alloc_pages (__alloc_pages_nodemask to be more
> precise), called from ttm_alloc_new_pages.
Philip debugged a similar problem with a KFD memory stress test about
two weeks ago, where the kernel was seemingly stuck in an infinite loop
trying to allocate huge pages. I'm pasting his analysis for the record:

> [...] it uses huge_flags GFP_TRANSHUGE to call alloc_pages(), this
> seems a corner case inside __alloc_pages_slowpath(), it never exits
> but goes to retry path every time. It can reclaim pages and
> did_some_progress (as a result, no_progress_loops is reset to 0 every
> loop, never reach MAX_RECLAIM_RETRIES) but cannot finish huge page
> allocations under this specific memory pressure.  
As a workaround to unblock our release branch testing we removed
transparent huge page allocation from  ttm_get_pages. We're seeing this
as far back as 4.13 on our release branch.

If we're really talking about the same problem, I don't think it's
caused by recent page allocator changes, but rather exposed by recent
TTM changes.

Regards,
  Felix

>
> At least in the case of Firefox, this happens due to Mesa internal BO
> allocations for glTex(Sub)Image, so it's not obvious that Firefox is
> doing something wrong.
>
> I never noticed this before this week. Before, I was running 4.15.y +
> DRM subsystem changes from 4.16. Maybe something has changed in core
> code, trying harder to allocate huge pages.
>
>
> Maybe TTM should only try to use any huge pages that happen to be
> available, not spend any (/ "too much"?) additional effort trying to
> free up huge pages?
>
>
