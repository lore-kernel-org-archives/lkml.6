Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbeBPT0k (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:26:40 -0500
Received: from mail-sn1nam02on0056.outbound.protection.outlook.com ([104.47.36.56]:52688
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751123AbeBPT0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:26:30 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com;
Subject: Re: [PATCH v5 0/3] Support Perf Extension on AMD KVM guests
To: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>, Len Brown <len.brown@intel.com>,
        Borislav Petkov <bp@suse.de>, Kyle Huey <me@kylehuey.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <cover.1517850302.git.Janakarajan.Natarajan@amd.com>
From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Message-ID: <7d5fbe31-e24c-8ec6-631e-6909bcef3430@amd.com>
Date: Fri, 16 Feb 2018 13:26:21 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1517850302.git.Janakarajan.Natarajan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR03CA0064.namprd03.prod.outlook.com (10.173.137.26) To
 DM5PR12MB1369.namprd12.prod.outlook.com (10.168.238.20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0db0e650-ac54-4bf9-e64c-08d575732d77
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1369;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1369;3:U1ubUO+DztRDivpOr212AWXm5M4GnLCHmHbXrOGVF8xcm7oacxD42KbFCUJmkZrsax/ecPO4crJw9HPbLglt9yWfWwKzXTFXrGwnPkYpsm3n5F8p/ryH+20RSRLaPRwpbcOi4SmBqOosyccehOqUDKkQbll15s5xi7WZtrefUpfM7uXpes/alDfoWmhkEyCQw8Es2Z+j8YUcYRx8EEHk0Mtfw1QInZXwLfD/Z8Od7sEBeAxsZg4er4klKUBDD0aJ;25:EPY8bDEPXaqJssElgkR/wDkNa3dmh8aqrkNyHNbSXH5ZAgcq4OZDd+aoW4YwEUpN16Ia7zSRI/0B1AKxb6cV7wL401xRUbvFjalE9vfxaR3Xqxoyb+lG2i1tBVd6oUYVdyNkQxU2Vr7yufdNiNCmd3psohcDAA20khZFCKCgrhueL+UzFh3b0pgDw9TfDDPCree6/Sf6pxPfJnersv0wWGsN85QYpAfnQ2xVO+y+wveOMDRC70Y2FKDBATc99PktXV30M0zxHRHCP9vUxK+Wpfu7FGC/IeHlhC3efgd3kdbbj2/hXwqj2AmCvX9bSzy05MwmYDaDdEfHzxLSmhWXwg==;31:LEyrmfZxzFiEw1yacuf29hxz/5ew2iuKLAJDhTnS3sqVcMpn+ShAN5wP7DoeLLkxsFUvl89jgpZiERGn9f7HoRPXvMEVev9ngJ8Wuo7ZGp3laczSMUDo4bIBKDlfIWKkVX6pjqdEsgNbfBbCIC6nxLkdc7xwTlWNyDBjih526Hr18ZLNLWC/jfUawlqtdApNTGNOdPNfSBxr0yt4jFW/FBc9j+4RBuhwokMRNN43M+I=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1369;20:eazKcLfig3VZTrRgKNGQwsySmexxISBagULkQAjyAIEJkqv45EREByZHShhqXLrV+GpMfYNvtaMffRO6AnzgCvuMLzYnXmYXwV/ZBYOYk3+6I7RorCn6rjZjh6lx133dzC/9Eu4NK9pkUZth6Jyqfr2Sg9WS+tlgi+LzITDOg1J7OhGzfW70ePz/SOt/Su7hMjC39u7gqOHIGlUIfGrq7PaO1Bc5jrktZdm/OO0q1q72QzcSTiidxoO2NAPxIM+XNQ/dxjDN5/vOB3kW/P5WwXsvY7XEu8PBHiXmP0xlfJs9OjuV1jzPLdSupsVF7lviAnxBgbZxUsaG7s6basoio8nxXMN4Tf7vkq1dUWU5M0Vz0I90nmlZx7G1j2H/1PXeYrpG688MqY3e3uCsO5X58A0HO1ePhjeYzkw+yWzn/qO2HhktlmxFH3LoILAd06XRnHUR2LZ1ZNkaagtLVzVl5M3aRMarAhryPzzNSB3KSSsBhYd0OC9iHCXlhAVBO1n9;4:HHMf31RtTm77pEltKSNhQZ0trTgHOwKEng2JSjAMXs/HTZs78EEld7g4RWrMR/w8CNMhaCUlMFhO0FejPDYM2DsEgNu/ah5muJuXFIPRz42oxiclVkU398aP1If37vAU90WyzfB4UrLUfimZSz8tp5NfwxW1HSZPAxDf+OxlF09Is7Ntx6XP20V2W8YWhQZFqK86yFAAFOvEwX1CdgoRQPFR9cdr0sgFxJ98vZEv4Y0ia5Lmkkj1VwqjVQgkvoonRSCFVaISpK8xRdAb3KSB7w==
X-Microsoft-Antispam-PRVS: <DM5PR12MB136962270D0FED0A5E4FDE1EE7CB0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231101)(944501161)(10201501046)(3002001)(6055026)(6041288)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1369;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1369;
X-Forefront-PRVS: 0585417D7B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(189003)(199004)(106356001)(31686004)(97736004)(8936002)(81156014)(81166006)(36756003)(86362001)(230700001)(8676002)(105586002)(2486003)(52146003)(53546011)(65956001)(386003)(68736007)(26005)(76176011)(23676004)(77096007)(7736002)(16526019)(7416002)(65806001)(52116002)(66066001)(305945005)(3846002)(6116002)(229853002)(4326008)(31696002)(2906002)(25786009)(478600001)(54906003)(72206003)(58126008)(316002)(83506002)(16576012)(67846002)(65826007)(64126003)(6666003)(2950100002)(47776003)(6486002)(6246003)(90366009)(50466002)(5660300001)(53936002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1369;H:[10.236.18.253];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxMzY5OzIzOmg1QTBncXBoQWhKcWlDZG1rWXRsY0U0WHlq?=
 =?utf-8?B?cXFZcFgydHBRNElsbjB3Rzg4dENVY2xCQi9WQUNvbWZlTis1Y2VaQWtVUTU2?=
 =?utf-8?B?NHk0VjVualNVeEo0a1JPenhRb2RNWUdzSFVUMmI1U3VlZnh6cklBbzUyYVVo?=
 =?utf-8?B?aXMyUEdJZ1BGMWhYU21CSGNaK3FQN1Y2VTBUWVMzWmFVNWRCVEYyUWxnbmt0?=
 =?utf-8?B?UU81b1JYbmt0aER3TlJLTlg2UDJUNVF0QWpmOE9tU3RtY1pMU21KTXBvZkpv?=
 =?utf-8?B?KzY2d29oN0pmejRyUjFlc0dCbUU4MGRld3FUdXFrOGZ4bU1saGlNK21zT2dI?=
 =?utf-8?B?bUxyVmJvRjRHdVYyNFN5N2llSG9lL1cvNGZVMFJ4dVlvSE1EbUZsclNldnIv?=
 =?utf-8?B?ODVjTktBQjBUVW5jRStEdnpmZDNpMndNcXlNblIyazlRWUU4TmdMcXVtcWRE?=
 =?utf-8?B?ai9wUEF4ZDBRNThsMGNtUUJyK3Arc0Y0UE5SaytxR0s4WWdMbll1am1idmR0?=
 =?utf-8?B?UTdIdThZRm5UQ3pvMCsvSk5HY29hanI4VUtxRmFsaXFMTXNXdVJGUi9wajlX?=
 =?utf-8?B?bjk0NUs3QzFZQnRLL3NBQm1DaE5ocjhqMXFwMEdWeHk1TmgvNG5NeFE3S2pL?=
 =?utf-8?B?aFhWcGUvVGVzZFlETmNPeUZkWnQ3TkkvUExqWUhzMnF4MTdwMmVIZGZBRmRO?=
 =?utf-8?B?MnNxeEpqY3FLOXF0MWNkanRQOFFNQ2FaSW95TXp2RjlUc1dqZ2tOTlpwNmQv?=
 =?utf-8?B?WTNEczJvU1hHNi9LN1RXVitZMU1seEtHNzZhdmlDYmg0VTYxZ1pKcU9aM1l0?=
 =?utf-8?B?a01sc0xvQTRVWjU0R3Fac2Q2enQzUnFmdGQ0Zk9UYmREaVcwejI2ZE1Fajl0?=
 =?utf-8?B?dFUxS3JCTlViN3o4NnZNWkt4aXZOdGI0c0p6WWJFZVpGM0FWNW9UYTlqbDcv?=
 =?utf-8?B?ODBrSFZiaFMzMmdXaXZYZ3Q5Wk1OdGV0TVpCNHRzR0pDUHZuOFAyM0F3SUho?=
 =?utf-8?B?YTNRYWdnYmwvVnhnNndpNkxjSHAxMlU5QlljRHJaRzkyNE5FN2FMMzdGS3U0?=
 =?utf-8?B?R3BEcXNZeGJpQys4MzFtUFhIeFZXTUJ1TGFJRkRPVVNpQ1lJV0E3dzNJVWhm?=
 =?utf-8?B?UlMrVXZYQ1VKOGNFeUtpMW5lV1lCckw2ZmlLYWc0UEI1akYybUhxaysxY1li?=
 =?utf-8?B?TGI0TXlKS05aZjlBTThvdGw4alRFbUkrWWsvcTllTUZML1Y2NkNqejFKaTBs?=
 =?utf-8?B?ODV5YWpNVlVFaWs1TWgzR01DQ2lDQThvcmIxWGZRck1GVDBzZU1QZStlNE15?=
 =?utf-8?B?VHBnSXpSbVNpT0pmMnZYRnZoak0xc1BBQW5oNW5CR2tkdG5RMTVxdWRnelFi?=
 =?utf-8?B?YVpFcmFuVzF1dlYwQkk5bnV1a1lFN0JHcWI0QTVIcXg1QXZYclBSWmVob0ll?=
 =?utf-8?B?UEZ3cGNjb2Y1MUNuWUtHMUFiMU8vcEJYNngxU3AvMGdROFNwVnFMRDdRK0lh?=
 =?utf-8?B?aWU2bnpXSmNQRDlNRGNHaDY3dmRLUUhFRDNRYVJ5eVRHZllmbHIzcWZlZHZW?=
 =?utf-8?B?dnNCT21RN0hKbVlVWWRrWkgwd1NWcXAxRmVJWTMzbTBtcThKY1pSa09DZkVK?=
 =?utf-8?B?OXlObmFmUlc2ZjZSOGk3REw4WDZleHRUUHF1TEg2WmU4YjNMeGNNZFNDVjRP?=
 =?utf-8?B?WFFJb0NxVFpveXppZDN6SXV2NHdJbUhQZWZQZHByQ0swbDNzNmt5dm9FUGY4?=
 =?utf-8?B?WWwrYm5TSkpNUnZCTFIybGlHYThzbVpYMUp0Z1VmaFRaY0JkYkZXZDIxbWxK?=
 =?utf-8?B?a0ZCZzMzOU5WSHhPTUFuRVYzUndGKzMzbjJNRGhDL29pU0lVbHlXZXV3b2M5?=
 =?utf-8?B?Y1NDLzVUOElyWnVtQm02T1VLUmxPN1VmKzI4UjZZaFFla1NpSlBGT1NRMEhO?=
 =?utf-8?Q?3lKEoXJKoFc9AetulKgGrv9DAc7Wz4=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1369;6:vh5gw52LP2Zrxd3jrPOx4DBFH3GDVSvjYyDognA7a0fN9GFZSbJ5O5T+jyLj0kOG2vd9ekdWVEcLzEDYv28Wjvy0VkF4Ww4YaKu7lXe74fegzw+n12Vg9qjjyJ4QT3w6axH/Pd6+OMIuGDqIx1CM3HtrCSdrnTU2tDa2ppLmE734YPCyFBPFyyjMR8i2z37KxqybeITXVf0PfvxS+GMTyOyLbvnAsGqKKgqp/YCuIHLFPW7zqxNbryCTQGFE+hovpfvtDfiADNIUz/XHwoYy/JTg18K7zlbS32NHHRtiuzkhHy/bI9Rl8huhOx0yv/LRAqNbNbND79qaH7w3r6+vUkDmJCmNSE/lW2dfOf46imU=;5:TWFV7AxK2W78/wY+2qGhqjSIX9ZDzUwspmOvJ+ai9tW1SNTTnH2bxqVuZZC+z3nzIXcUDCzMZj5HcadrVK4X7liSDD2uW9dNKANtPavQu1lhshVNW1H0YEuyKWVW6bO7SlBeUMNnfeG+84Vnr00uhsHtlI54j7MzH2W74wlnJEY=;24:cnOa3zlcRiFmmXLTuDSlfCt3yjdzAq4kjjO+/ZWWcbyWoxEddWbsH2va+PQvqcvwte2uqrgUXV0ZoL5xPNScjrW8xGDm13LbxWaxZxABt+Y=;7:qU0QpHMbmV6gx4VNVLaplyopxr1ISt7NAXhlsuud1h9XQ9zywCgjMLH40596doYY/ohoLFSkkMod28IsvtqpneoutPL0B3OXHvokgTJAQnFhxrG+F6eeg98uIvMSxNX+e/RtAgyWjlJni5ewob/n3S4pLSRS5skCJa+c9jS8hzoOlQONhRYV01OHskmgg6cyZi6knWOOe8aGFLzTfDT7hBmj77arPFA7pLQLZ97SjSHXLIskEVLfbtGBzwH0W+S3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1369;20:ybyVy69Jobe/CpsNRNsiIbzwW5cuUPiWf9EU7vVOgCf3u26SaZObie8jLYgYYevBzgPKbV/RQ7Oci62G5utf+k4pTSYFWiw8gCNpp2BdOfDSFyyeZExjhrB8Oe/8SrVLhdnd7PFVCT4Xf36woRiY7VpMWBz7YHDc/h8L1a0AtCMnxMr2MGwMLFzjMCX3dH7cmWAspy6xM9tXMxQMS6ntGT/5eIf3mXfPYqdCyVNZjZ7z42UNdcKNFQivCj0ysF++
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2018 19:26:27.6376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db0e650-ac54-4bf9-e64c-08d575732d77
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/2018 1:24 PM, Janakarajan Natarajan wrote:
> This patchset adds support for Perf Extension on AMD KVM guests.
>
> When perf runs on a guest with family = 15h || 17h, the MSRs that are
> accessed, when the Perf Extension flag is made available, differ from
> the existing K7 MSRs. The accesses are to the AMD Core Performance
> Extension counters which provide 2 extra counters and new MSRs for both
> the event select and counter registers.
>
> Since the new event select and counter MSRs are interleaved and K7 MSRs
> are contiguous, the logic to map them to the gp_counters[] is changed.
>
> This patchset has been tested with Family 17h and Opteron G1 guests.
>
> v1->v2:
> * Rearranged MSR #defines based on Boris's suggestion.
>
> v2->v3:
> * Changed the logic of mapping MSR to gp_counters[] index based on
>    Boris's feedback.
> * Removed use of family checks based on Radim's feedback.
> * Removed KVM bugfix patch since it is already applied.
>
> v3->v4:
> * Rebased to latest KVM tree.
>
> v4->v5:
> * Removed conditional check when exposing Perf Extension flag to
>    guests based on Radim's feedback.
>
> Janakarajan Natarajan (3):
>    x86/msr: Add AMD Core Perf Extension MSRs
>    x86/kvm: Add support for AMD Core Perf Extension in guest
>    x86/kvm: Expose AMD Core Perf Extension flag to guests

Are there any concerns regarding this patchset?

Thanks.

>
>   arch/x86/include/asm/msr-index.h |  14 ++++
>   arch/x86/kvm/cpuid.c             |   2 +-
>   arch/x86/kvm/pmu_amd.c           | 140 +++++++++++++++++++++++++++++++++++----
>   arch/x86/kvm/x86.c               |   1 +
>   4 files changed, 142 insertions(+), 15 deletions(-)
>
