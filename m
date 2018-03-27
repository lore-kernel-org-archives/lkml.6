Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeC0Lej (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:34:39 -0400
Received: from mail-bn3nam01on0087.outbound.protection.outlook.com ([104.47.33.87]:51712
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751092AbeC0Leg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:34:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
Subject: Re: [PATCH 0/2] x86/CPU/AMD: Add support for Extended Topology
 Enumeration
To: David Rientjes <rientjes@google.com>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, bp@suse.de
References: <1522051559-23415-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20180327064806.dy5updhu7grlct3q@gmail.com>
 <alpine.DEB.2.20.1803262351340.261728@chino.kir.corp.google.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <f6a804d1-955b-2498-0ec1-c664c4ed843e@amd.com>
Date: Tue, 27 Mar 2018 18:34:22 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803262351340.261728@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: CY4PR19CA0038.namprd19.prod.outlook.com
 (2603:10b6:903:103::24) To DM2PR12MB0140.namprd12.prod.outlook.com
 (2a01:111:e400:50cf::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4ae6bfb1-4648-4f01-d602-08d593d6b62c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0140;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;3:sNt/CH9UCUHx6qzsQwyO4oGOWsbhA8AsFoDOaWfDyw9skobhrVS5ES5zxl+fC8aut7PMi7VvrYG4acRA1weotB+W2q0h2X7uGWtDJq3/Kw5J4shOOnvsVQZfvgleVPm/HEMZkfvUvvb3GC3Eewv/w7zO3d29fVEKbCPX5dFMcnj+t1yXYwN4FHJOuIANUshbwCJX1M7+d5Ao4diVoQ3NcQbMs4PEBEEPNB5VjnrTX0MZn/ZFmYnDwjTc92KCELA6;25:TfCrEMwIgRIfvE9DwI6jwxXPLqC/lIoZNCHDMRibCkq8vUWybhvWDcNCKUP9V92FK2UnvxakSaBjdoBSADS3RRsLsmm4L3ERCI5a7qX1HNrDMZnY+T2pY+fBgm6R4ubMMMdzI1MGbKzuJpeqOFK5yrUkB7sMoGfWkhVUyArZ2pZt4yLV57zHTf+3wq4CQos7tU4HspfnSF1kEdXrmzfNFMSCtkbnVm8lf+C1a3oX3/UM5tfIn8fNJBgPxSuLZy3kMqu58G4PQ2x0QIJKR0Kvh7N8S/sO6QqgShDoTp3+9kN5zPyhOUFR5fhSZQNzio3pwYBgJvUifGN42/JGb6l6IJfA27bqOatdoMPwSnGtuNM=;31:3QOR7M3NV2b/955WZ/Znb8ky6WfUqbGjQT0pBPNp3ALKxwy5lSw/XQ9YdTI22aAB+g+pjOGQsx1LO2becOVeLbhoty8eBaKzOQ4RLUPiTT6Ff1tr0EWiSJ8USc63AEAZshtCHziWBIzj2iVLa3mENiQFoZ3jDPvCywejqxp0jfW++MPiiMebVvw0OrzthCeTI67vCU3vaWqhlwcu3YhD/w2qteR3JCT1a98L+2uuNOw=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0140:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;20:Vjp+PaHL4Biz+oYnArYOIYXBak8889He9KNWQdCJ1m/sj8FWRUfaZ/iLSxKGgQT3KKvic90rB+twnUaS6u3UJ78H74goDCgJeRcmoIiRUV6TU+2tQHAmyQrr6qdsdUNWsY3NgOSpkbDGQpN1sgXpCdQ9MRQaRF4LQxj8z39Oxjbrxo2TVbvxxw7OPeDKAevwTp0IryqCQig0qpDr30IMi5w6CQa0XXyWgPOBMCTwt23PUetY48vLDshuMJL78Rlbrh8P0rPyM6qWCC6cOqnelTN7KiVLiiO0iWoygDKyux6uVKGfG1lEycaP5p89cTdLPYHl+hRiJvNfmcNsMYIqqgKKz1XhBNnkIDnko6Zea3kF2XvYKzODxmCLauug7Z5LN3Uc2L0Kfddcuwi3EOkvJSPWwXwj5miGkovoXZXENdMxLCijZ/iNjx8csn2E6OMaZemg9dJZSFfhxRhcyQBFH3jwm9AgH/uK/A6nQxGdFuJMThPY2RAG+XhvvqWMAHhV;4:EeJEX+4DoHBoN1zXctNEWogR6i3Kj+gz51sXz4lW2mIQbX/FmGetWTdDwZJ/JplsZq+n4kl30TF/0lmCa8cVssXhetbRqmyyh+C9k69XD5lY0hM6+Jjyhu4PQ/LfDG5nDfw+c+6utVCHmkW+Y616ixq8ib28zbAueB8l2mt92wGtaUFCSuY1eNes2c9UIp0wVDT8KBbEOitjF51rlqQ5yBXFObhuK4lYx+ONH7BzNMgwVsF2mV3qj1oCzyM0/8mRKW9Nk65Ac0MTuF/K/Kte9nf2eSLynRoBWduwIlPo5OVqslg9TtHUg9hpBur7FJrp
X-Microsoft-Antispam-PRVS: <DM2PR12MB0140DC21334B821E5A52D415F3AC0@DM2PR12MB0140.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM2PR12MB0140;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0140;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(53754006)(189003)(199004)(6666003)(53416004)(31686004)(478600001)(81166006)(81156014)(6246003)(8676002)(110136005)(31696002)(105586002)(67846002)(446003)(956004)(305945005)(7736002)(2906002)(230700001)(106356001)(11346002)(486005)(575784001)(316002)(8936002)(486005)(2616005)(68736007)(25786009)(86362001)(36756003)(5660300001)(26005)(4326008)(6306002)(65806001)(65956001)(6116002)(66066001)(229853002)(65826007)(7696005)(16526019)(47776003)(50466002)(72206003)(52116002)(2486003)(23676004)(97736004)(52146003)(76176011)(59450400001)(64126003)(476003)(53936002)(966005)(3846002)(386003)(6486002)(58126008)(53546011)(186003)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0140;H:wsp092918wss.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTQwOzIzOkVWYWV5cUhsbHpsU2R0N2hPY3F5Q1dsUGh5?=
 =?utf-8?B?emFXWWg0UE4zVjMxMmhYVFBxV0JBTUpQT0IvYmhLczRqYkJ3UXpPOEF2NDZW?=
 =?utf-8?B?ckRTZHRGZitpNWgxRW1HazFtZUlGMG1FdVhwdEw4Vzh6bERrNXhORCtSbXpJ?=
 =?utf-8?B?NjVlSTMvc2JNWHl4cG9yRUtZWVVPZ1ZMd0Y3dTJJU29JK1Nodlc0MnU4b0dI?=
 =?utf-8?B?R0Rzd3FPbEZyTlBzdHR1QzN2MDAxcGowTjB5WXhsTCtOZmtQYjc1dnhBOE5F?=
 =?utf-8?B?VitUZjJoL0owN0VsTzlNbWNLYStwMEhuLzhYS2h4YmhQbVJlWERlSTlaQkVB?=
 =?utf-8?B?N1RYVTdWWXBRdjhBNjRVYnZ1MEY3bmFqcG9PWHUxTlh5S1dVNGl4YjFjdktQ?=
 =?utf-8?B?R01veTR2d3FXdkJ5RTlLdFh1aUpDbHhhZXZBZ0Y0RFNucVY4dHN1aHdKellT?=
 =?utf-8?B?R0JjeVhDQVhkNGc5LzVPeEVKUitVYnh0RHJRYVRTQzRwZ0E0MWJVOVFWNkJW?=
 =?utf-8?B?TkJLVWhBaUJXanhpa2RNQXp5NTZjMlZaVUxOOVJCMmRXeWpTSzdtd3NEdHNI?=
 =?utf-8?B?RGZEa2JOOEwzNzRRZVptQTlwQ2EyclppWmN0eWl0TnZ2NS9vVFpia1QxbldQ?=
 =?utf-8?B?MEtvQlBsSXZTQXV1em5ua1YyeWVpTEtBVisyRmJORmlBWFR3OXRRY1h0RnJ1?=
 =?utf-8?B?Zkw3aXhsTkdYQzlGV2pxN2RxTjFuUDZyVEtva2UyTnY2bzJTVEd0czVUTkZY?=
 =?utf-8?B?d0NkS01BdHZjVWpyMm5JOHUreXJ3S0grWHZ5NzlVYVBUVWhHOXpLenF2UWxZ?=
 =?utf-8?B?Q2l1ZGdLdmh3WHRiZTNIR1JMQ0lEeTVsbCtqT1dncXBOMVlENkVWeFJXNDZF?=
 =?utf-8?B?UWwyVnVid3hMNmtpL2M5Y09zR1hzdkFVaVFCdjIyd3hqOVkycVV5THhXUUxS?=
 =?utf-8?B?T0xESEQrQW8wOEtNVUhQb2Q1b2YrR3Iyckg0OFJPSUp5S1VYbzErbWtpbGcr?=
 =?utf-8?B?czBjT3lnS2krb0lUeDFjcU9EbnNDb1pNMDZmU2JZL3RHUkI1dmYyRnVMTkt4?=
 =?utf-8?B?dDNKNE9MT0tqa1N1QmhkcUJhZlZPUnhzTHNQM00rbDR0Z2hNcVcyNmZMdG5z?=
 =?utf-8?B?cGNJNENsZG03WDRTNTRVeDh3TG5OWXN1RElTWnZHbTVSdG9veVJZM3gzK0tt?=
 =?utf-8?B?WE5PcHcwWW94OUsvMmRwVDVER3BIQUJEVG96U3M5Z3ppSW53SmR0YVZlY0Iz?=
 =?utf-8?B?MkpQMUNDdjloWTBLOGZPaCtTWWJST2VobTA4ZzJhYi9ZUjI3UnRSVUs1dkIy?=
 =?utf-8?B?Ymk2cTlRank0UjBhUEpNNDJHZVl5Uzh1MEJ0Y1E0THkzV0Z0WmE2dFpJTFBY?=
 =?utf-8?B?OGJrWi9IZFlTQmlnWDZCN2pBcmpMR0VlVzZXUFVqNFEvdjhYWElSeVJmWEp5?=
 =?utf-8?B?QTFYSlQ1dnRTNHcyZlJUS3FLTkxkQ1NWMXg1NmlXZ25VejRoVndPMUdHUFFz?=
 =?utf-8?B?WmhaRzFpQkhQSG82SlQ3RVNmMldXakhwV1RoUFJEWWRVU3lUNUVvbUNMNnF3?=
 =?utf-8?B?L2ZpdDN6QVAzMk5abEtBQ21oMW1MeWpqU1gvM0thRGdqa2dML0xRdC96YjBV?=
 =?utf-8?B?NER6TTVVdGVNMTVnTjcwS2xDNHFrbVVrMXVSOUE2ZGllOFEwRXVEckhYbjc2?=
 =?utf-8?B?YnVRYkN5cW1LNDIzcTdPby9acjdncTh3RCtZZmhaajR1a1A0WTF1bUwyMHRv?=
 =?utf-8?B?WjJ0UHJFbkljMTZXVGgvY3h2TE9IcXo5ZlFkYVpQRkZrQXlvRHJaWjBKczNU?=
 =?utf-8?B?TDlhS3dhd0VWNm9WV1J2enJFK3h4dWdBVVRsWG1oOUJzLzlIdzU5aE93MDkx?=
 =?utf-8?B?RVdQRVIzUStuT1J6Y3VqUkI0RmZVVkR5R2NNcmNhS2pPemd1WUhJbVkrRG12?=
 =?utf-8?B?Z2ZvZCtobzBjOExwNi9qTmtpUjhpa2d2K2gxdTdxUk1SYzh1YW5TeDdSK2cw?=
 =?utf-8?B?bDVBWW4yYTBDSVZyd1ErT2hVeUlVOHRZeURXVE5PcHp4bG9KVVBYV01jR2g3?=
 =?utf-8?B?and2b3pVV0pWcisyY2FXc0F5L09KZEc0b3JTMVRYMjBOL2xtNHFBUFk0RkI0?=
 =?utf-8?Q?TYbfEsmimaMHL4e0uB5UsgZnLrUCh6bVdfVJUAlldOaN?=
X-Microsoft-Antispam-Message-Info: ePIC2AgANxArTnAovTz120c9xLf73iC4sveqo0ucuJ9shNh/VZMnnHJSpqEOEV/U2papNOBxOk57q4Z+MSuGDg9jWCCR9+cwHFEF/WjQqWV8HTm8JlEjhvF6vYAIENPyBPc53a432Nbx5lzH8rXDs0G6qyPH9RdGJiBzGC+awHSQem5N5iD5yzDc9xTiOIJh
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;6:xJ0IqZTgYvF0lFLSK7Pr03K4EIV4snXE1gCQRrPuNafoETGI83qkbhCsPINOX2MDz5y3newscpr/IvxvcDZ/KkZZqxDmiANnOgPcIloTKKxOMB7UBLf2+8kSpvT4eBlLfGLQJrP/72VGQunRT4Gd1VjJBAL0bXLT8IwU3g1GllV93iseHODcpHALxbdspDj1/+EWLGWRc6jZWUNTL5xv3H4JsYBXu81L7H5cpJaoeVZiDHew99BtGgUHz3E82snc2nAHaUn5iwDQ9oZOtSdQGpvDpxfE8iaFp9bjnhhq7HCjEvmwFy626l2dPADRGSsXcgGOiEHC8+A/jjs29TMBB+0v+wkasXpQkzUWVj05YvZQ+XomDfsv4j92ObhFB2gtlJHGSlMNkKJhS5unHAn0HQiH2H5bM4uxAr17p+jhQyIyBac4ZM12QgtU7aEObE5G+LK2NI9itkQ7RENnMQ5jyg==;5:NrKcl3O4wDItipeJaRol9eXnTAWL0x31zH9ktvr1s6ahFMEClpriRCn3NvYSLiLKRok2pNEIFQMG9LVny1RMAtVNxcJ6/GBDsK277u+8h1F17K3SkSsnketAVKWE/c0b2YDUQQkFxEwCKeDYpJ0pgRDvVBaBR4O3gDk4bUVcGcA=;24:1nv1vGRngJfOimZvF05j6EN51bMWgr83Wo8nVqio+STn3T8jOBtf8Q6OBjYF+JXz0r9J1U8U9K0uF3Se7v/njKL8YarycB1UbPetlgNDBhk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;7:e9sA2PPTEGFq7ssLm934NlY9dzDHvkwc6YzqB9MQmU4WPWFwkO8s0s5S+xCwDdA9OB+fcRS8uvfYJfwWU3PBSd1hDX2wAqAebXejL0ToPLzQXjlY/XOYAzz63ezFAndC6/TLiB9+FCf0KM7iAiHn0gqK4XduhV+5jELsC9bUqGigNcewLsYuOH9gTmCMO2q/QgKbpm3kV5a89Cs19fG3Jw8KbPK63iUuDLoXsLymu7cItTWZG9XaAdNXpT0WbLOu;20:zHzL0mTh5+bpj1vZfFlCbM55L3dfoVfpYcbu2DJl53DAESpKtoDzLUSCzZnO6XvT3x4QB7m2QpiQMl1Gd3BDdrPMtwCrkBqIulazqFKspGy7Bu/vVGpL/CPeGU0qddG9c7Bd+KIiOJB1PVSZAON/++qLMw8NkXmX04J2yxlJ7KEHH0D0xztgmD4E8GkJN8V1KvUOYoIUkDQ4OGXllBtA4fHeNkQFi/RMod2uKqUvYcseCiio3BD5420e6Xpeq5E5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 11:34:29.3656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae6bfb1-4648-4f01-d602-08d593d6b62c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 3/27/18 1:52 PM, David Rientjes wrote:
> On Tue, 27 Mar 2018, Ingo Molnar wrote:
> 
>>> Linux currently provides function detect_extended_topology()
>>> for parsing CPUID Fn0xB and derive CPU topology information.
>>> Therefore, also call this function in AMD code path.
>>>
>>> Thanks,
>>> Suravee
>>>
>>> Suravee Suthikulpanit (2):
>>>    x86/CPU: Modify detect_extended_topology() to return result
>>>    x86/CPU/AMD: Derive CPU topology from CPUID Fn0xB when available
>>>
>>>   arch/x86/include/asm/processor.h |  2 +-
>>>   arch/x86/kernel/cpu/amd.c        | 16 ++++++++++++----
>>>   arch/x86/kernel/cpu/topology.c   |  8 ++++----
>>>   3 files changed, 17 insertions(+), 9 deletions(-)
>>
>> Which tree is this again? The second patch does not apply to -linus or -tip.
>>
> 
> I was wondering the exact same thing today when this came across.  I found
> it's based on Suravee's other patch series posted today entitled "x86/CPU:
> Update AMD Last-Level-Cache Information".
> 
> https://marc.info/?l=linux-kernel&m=152204614503522
> 1522046116-22578-1-git-send-email-suravee.suthikulpanit@amd.com
> 

Sorry for failing to mention the dependency on the other series here
(https://lkml.org/lkml/2018/3/26/24).

Suravee
