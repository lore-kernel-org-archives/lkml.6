Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeEVOMB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:12:01 -0400
Received: from mail-bl2nam02on0051.outbound.protection.outlook.com ([104.47.38.51]:38432
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751308AbeEVOLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:11:55 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com;
Subject: Re: [PATCH RESEND 1/2] Add DOWNLOAD_FIRMWARE SEV command
To: Borislav Petkov <bp@suse.de>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <8adf44db473ccda6ca626ecdaa058d524af189b7.1525881878.git.Janakarajan.Natarajan@amd.com>
 <20180510172813.GD15817@pd.tnic>
From: "Natarajan, Janakarajan" <jnataraj@amd.com>
Message-ID: <a9419c51-17fb-55c7-317d-4bd809253e26@amd.com>
Date: Tue, 22 May 2018 09:11:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510172813.GD15817@pd.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0201CA0027.namprd02.prod.outlook.com
 (2603:10b6:803:2e::13) To MWHPR12MB1375.namprd12.prod.outlook.com
 (2603:10b6:300:12::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1375;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1375;3:HNtCDd0gqh10qjmxFEM1SUSt58vTcDZGHbNPOkTRyPUj8Tcey9LMKDWkhluHJPsosXWo7yehPjZMDYZ2UCzUe9oxoN1x08VEP8uCtwEqZOrWwfnFi3XcEYUjcZqG22vX4YUP/sJJwt/ivnkYahedmYaeXMVwGh42O3KAwp9tjbKLkpMMxfNHsYxa6Es4TbnH6rXgPaNK9rCHchC74Aaml087P5qxyJFJjR+rHA7IR5J3p3ZQlrVGRKq+SwExPXrL;25:risGei33iZflqjpsKNAdi1wKZB56H3/edYjQCthhgktR/4co54NcJK5InjNHBGw5eKIzlAio7QTrMNjBslawEv7sJboSDnknbL7ydXkI0whUH3Kga631VfAYzYD36LBJACb9oG7JZYTUaH2ePRmlRW06TtAOzYjSnPTfZywUaZ5GrYhkKsI34ZBanGdQwJ9f71EZ8rwv8BHrFobiLNMfsaOcQTxk26ZmojgGEJm/PBNVhbhqbynhQ+XTKdfLRbB4x3F7d6Al2c27Ad+J2B2uF5jDt7/Ln7gYdiezvWjaj/zg3eWya0OFOrttvq4dJHqGlg0jJDNm7WzRDvXAGHGJcw==;31:v2o7+ozy9LRXqKWQhqw3/W8ORrwDNIhaQBfLuSvaew/z9DHwAUCxQeazlm5+B5ySn3O/fIK1PZ+JZAE6yc+hWlU/YqE8SYy7R4IjglcwEXeB0nKVjrKjQaA04A87bj5IP0B6SsmMY2nNZGZmtN2aZ/goV0dyF1IzLMdsfsfClTJZARz3RTTWJHfpw6L6JTlJnyJn/Inhpezl1zBfkD1LbKFqQoEcOiTrJoax2TCZZko=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1375:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1375;20:Jr5dVonF2548j2qcHPiOFPG4AnJPWj/6jhSUJaiDEOPosR+8iEK9WI5OL2V/ENtx/8Bn6Qp1w07S61pRQHAguu8hNweWakmhhkW8gHa6zjkbCuMBENRl9+zBL3YU+TqTx8j1rte5BYDwj9dKnUlDxbNeg2XC3ZkpPRoXrpsGxcY7KtDKijfeXC9pf1+BlDkqBe5FWbhW0qRkEutRVRkuJ/KgoFvbV3P5/oNpDUZl1jqPilfvylh4D9GVWMwrKpTP64SxT6pW/z0x2opwuuqpT69XUvGB3hg1c/dq5b3ptF1BzVPRRBtz9X8cqk9ACb8FxA/icSI1aQXarL3dyG6c4bbwFQWMug9uqP1AxMovJLPQG5NYc2BcSS6Oum+rwQCBRsu/+CxdLuOtFpcFir991VOxtphdLZK2pqyVsciXTcAs0DcfgOiruOcRQXSDJ6GhCv8qDnGIhN9USVB8X1YMIabxeGN3azD95NFMrwv9fNnW47H3NvTf3YsQmkqfD15t;4:Pso1LcZNMX5qLfhFJLsskhJnv9JbO56CKWr0Pwrr95e07K7gt/OAfwoJur2kSel/43gi+5/1gX6WUZEguXjl+IP+7eEK/4cImCQk1l8C3bT3DwJGl7VSBNN+VUKA0lKjrOtM1vUC1/9h75D44nNKHOejDsRo06rphotoOlUS30RziiksG7aOgPF46EXtTaqC6qRBWT1zrClkAv1gQ0nULKfFJ03kb4cqGpXXfnLcHoNqm6yP462iBHtsA+CgyoxJD6F1xUg7hvBXeuPVEItIeN6Y6IRIqRiiCHBpw/D75yl1rGvUP68RPZmnd067dcOy
X-Microsoft-Antispam-PRVS: <MWHPR12MB137592619DF14C5C7623DB12E7940@MWHPR12MB1375.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR12MB1375;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1375;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(39380400002)(376002)(366004)(39860400002)(54094003)(199004)(189003)(105586002)(5890100001)(478600001)(68736007)(6486002)(6306002)(81156014)(8676002)(8936002)(81166006)(229853002)(3260700006)(25786009)(6636002)(6666003)(106356001)(36756003)(7736002)(64126003)(5660300001)(31686004)(2870700001)(50466002)(72206003)(3846002)(65826007)(6116002)(2906002)(966005)(16576012)(16526019)(47776003)(186003)(316002)(54906003)(65956001)(110136005)(31696002)(476003)(446003)(305945005)(6246003)(66066001)(52116002)(59450400001)(67846002)(58126008)(97736004)(76176011)(2486003)(386003)(4326008)(65806001)(53936002)(23676004)(52146003)(2616005)(486006)(53546011)(26005)(11346002)(77096007)(956004)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1375;H:[10.236.18.253];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMzc1OzIzOmNYZDhWaEtkcEdlZE1MSjJ2OXlDUmpPMmcr?=
 =?utf-8?B?eTFhcktEc1lsSFZPN1V0NE9FK2tvb1N6dzJZVVB6dlR0Y0xHY0d6b2hBQ24w?=
 =?utf-8?B?cjZRbHRCSldYazhmNS81dmlFSmVBTUNUN283WnNKUXJ5dlN4RHcxNnk4MU12?=
 =?utf-8?B?S2VCTkJzeVJiMlhZVVJXMXB0SkQxSEhDdkhTM0YvVktLVm00UlVYckU2Slds?=
 =?utf-8?B?cVFqTmNwSVFWSTQzM3Zhcy9tR0NyZEN0NmVqMC81cGRSNnQrYkx3YmVrTFdo?=
 =?utf-8?B?cm43UnV0Y2RPT0xIdVFQTG1qSDI3SE1CaUpuNzE0bWN2aG5BYndQcGE3dHdp?=
 =?utf-8?B?dmdOV0UrVFF2d0RwSG82bERSNjlJUzRadU9BR3J1alpIZFBSVlFLMlh0L01N?=
 =?utf-8?B?Q2psVHJ4YXVBbE9od1Y5a2tUZ2NLd1NvUzk4Y2pqNEp1YXNPbzFUWTBYZFpa?=
 =?utf-8?B?bWlJOExyRFZVdEE3ZldZcDJMa2xrU1QwMk95ZXIxTHlmc1JnblpDWmpDaWxx?=
 =?utf-8?B?UkMxTzloZ2xEaWxIcDVVRmxOVXRBVG5RelRzbG9rTzBRaHh4U1MvRzRsa3ll?=
 =?utf-8?B?Y2drNHUrUWpqSFhhNjBqbHVudlNZL3NPVnJtNFNNYXF6bVVHSWVjOTVRdXVa?=
 =?utf-8?B?MGc1dGlGQnR3bjF2MXFBUlo0VitUV1JoMWN0SmdwSjJ0RW4rMGxkTVJyZmQy?=
 =?utf-8?B?bTRBNHpLVWpDWFV0a21PQ2dwZFFUR0Q1LzVLVWZnMzFCNjRNQ0g3WWtINm00?=
 =?utf-8?B?OXEwdjQyanF3Tkk2Qi9vWjZocUtPNmlSdTRGcTA4ckk0S3BNeUdjR0x2bytP?=
 =?utf-8?B?Yk9BUmswUkVLbUFwM3d6T3QvelF6enRLV3RTVjR1aGFsWXpYMFNmQXd4SFZu?=
 =?utf-8?B?UVhZc3VwbUE2QlZtckpteThEUWY3ZWF6QSt1R1ZDYkRvZlVxQmRwZDJSbUNw?=
 =?utf-8?B?MzdhcmE5L2pnN2dBRk5TejViVzNReTF0U2w1RGZHdmZWd1lTRnBLSW9Db0NH?=
 =?utf-8?B?Mld3MkRrY3VSN0xEYkNicTZLbmtoRGJ4bG55Wnh0Tk9RM0ppdVEzM3V6MFZE?=
 =?utf-8?B?cVRCTzdsZTRwTXRvSVFqcWtsaFJlR1R6WGRHRitpRUN4VWY5U09WcFRlTzVZ?=
 =?utf-8?B?ZngwdzJKNTlkb0llcWhLTDdOR2dMUk0zeVZwWE5QRDBEQk1oK2xvckk3WG1V?=
 =?utf-8?B?S0FPdEdFMDhGV3BIRWxYOGIwN1Nza3VJRGZISU1yY1ZPRTNZQzl0cU9Fc3JK?=
 =?utf-8?B?akowQkQyTzJrZitndlBFZklHemEySmh3K0NodFRXUmthcXVURm9Call3bnJT?=
 =?utf-8?B?LzBMdUFnUlNPbWJHbnB0UzBLaGtzRFpaWVFnYS9jUE9yZkJ2NDZpZ1gvTnU1?=
 =?utf-8?B?TGU5RzVDZ3pXelJIemVoMkRZK2hydTVad2ZvTThmQkpHL2VHRVFYbm9La0pl?=
 =?utf-8?B?cW81SFc3N2Q5UnJ0WGZZN0JFUUdrQjZySFJLVTVXY0hpVHFzV0ZpVlVpYVZJ?=
 =?utf-8?B?ZnYxbHpvemM1NG80MmljM25BKzBnaFBOc01VSm9TNUlPMjk5RWpiMDZvNC9P?=
 =?utf-8?B?d0ducGxySUZzV2IxSk5DQ2J5SjhRMWlxUHBSNS9XN3pvYlZKL2VxYUdOMXVu?=
 =?utf-8?B?Qk5UYzFydDRhZGFyckxUMEYxcTVKNkhONVhZUnlLbWVLTCttcEh1ZFVQSlRU?=
 =?utf-8?B?cU8waFdUQUNrNHlSazNOVW44TlMzdmp4VzFJVWRxZjJnRGhDS0dWMXFualNL?=
 =?utf-8?B?cFdsbEZPZUVDT0w0YWJ2NWJURk4rdWZYUGFYVjY4K2tsUDFPRm5VYW8wQkVZ?=
 =?utf-8?B?Q25zWkpVQkVEQkdQN0Rpa0FSWEV5VTB6bFIvNmFDdGRUOE5ncEM0Q2hRbzZt?=
 =?utf-8?B?TUxUUlo3ak5LMGlLN3ljdFEvUGdvbkdXVDdFUHhreUlCblFtSkd4ZXJsVHNC?=
 =?utf-8?B?bGxtNVpWdEcrQk01c3ExUWQxdEtUR003dXhlOVJXV2dRL3JCQ2VOOXZJU2dL?=
 =?utf-8?B?MVlEbkhnUGpzVSt5Z05aT3E3ejA4ZmVQclFEejZtS1poQTI0eHdmMUVlSW5w?=
 =?utf-8?B?OGRTbEw2SFlKaWJ3V1d4MEthOEl1T1BBN2Y3N0RKUDJkbTRlVkxPQVVQdndO?=
 =?utf-8?B?SkdxSFM0THo1NWtJbHpqckVNb0JzcUZ5ZlBGaFFWVXRYQ0tjdEhNaU9kNjN6?=
 =?utf-8?Q?beKOYYz+FY8LsKKpT7PYwmD/VpztzBzk/suN6AKpvo=3D?=
X-Microsoft-Antispam-Message-Info: 2L6q71XiBcHhSq2o5279ycvHbqx7/g5DWmD1oidJ9YDskcNExka9M5gb8HQXQU9vq/2sqsYdPoWKbSeqgoQBa1RR70EyeJuhbL470QyJMiLie+paIEuwsEcykPoHoDHOD8XE8bbtAQQyn3tQdcyvyEmazhPHDYdmCEClOAvSv03i3aalrCwnK5Q5vYg635Ff
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1375;6:YLdqfx2SPk3T+kFPR9JQSVnFlkOy4LmrS4ZUS1mjPq1F7Zf7phgOmfLODiyhLyt/01/HtkpRpl/MgGmOurE9WC562xm2ShwSm2Q+QyH5EyZwYw6re2/LZ0J+MojxWpHSeJLpnMM72oH2Z3dtdC0W616k0vZQhl0DnB14gh4w4or5JeKopsuh49WDIcWt/BOsc1Qvn0Sm6n3RyynGxsTmZwgcEszc0nbRCWNpzxhjJhqG0qlRxIBhpX/jTckRRrdX5XTTBI/18qXq1zCyClUKsAt9jHnstxVHLnLxe0KnGpA76w24cz/x0Qtet2ikN3nMZM0B/VET4qdVRsrQV5slloDBO9UmodHT06ThXjWzVyV5MZNXqy0x7Z05m1PZOGtSDLjCWwaeRFgqVRw/Szcvp5G6polwVTKhfksndhnE7nEFy1KvGAkcLXKZ51FDgk4BaPKdioPBdtOCtAyrFGMfOA==;5:BYt33ri3+T1Af1xfHNAARMkKWn04vfRUHrrsjCjsXR5n3EULs8pR3CbPA5iyPkxo+NkmRalDiMw0DaMsuIJbyO6wWAt1NtXnO++z6PWOwm77Mu1GQDjsgYSOg6Ahf9OBErVnNMU1cA6EhZoTH5fv9aqUU3ugrnT0zymIMHq4krc=;24:b0PnDBz7u9uzy3wDNlWFawW/LCU+4/N/J34bFLeC3xeRKfAFFC5uxIiAsdKMOxR8tcAZkgxMLCdpXfgfXp+niPvLc6p8kXEZ5YKr6vfLF/8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1375;7:b31rWHAg6F9t9DDAFOBlZn2cenxV1aovYw9pUZnEc1f9FtAo1/3EHxQwSQoyg3vswNV5wGHI3poiYUPE9xKBrzhpdbhBghViNSyr0TmcXe/BLjcKlPEF58yqo3+d6KqrNNmZDHx5SLdT1Q3YD2JK7i2NmzFslrhMRC4K4OtYrMv3z7UvH9UeZTB4BkFC2/GKbNqJzH0yQdnFEXcIgXLNIAJjOHU4JgRY7BuFkSHyOMwIRC9HwECR+63xH7RIxjHB;20:esu/3bvIvlfVNcJ1VJbfDXzeoF5/tqqaB6sPVtfUVv6nLR6o8YXzqpbpRxoZooQEK8GZk6yuyMLaeeIONForGG90hSezpI37V37C+zSyK9Vt0Zn1aSNUMQPmXR4L5mIueoDlvHJ8i1Z7EmQ59j0xrofDLMOdHES/EBo4SCH42n5YbMJT/Cz57VH2scVg8xKntfFhvVg5/TVebTy2TdHasYLa9AypcGKUrwmOAlOTEaqzpxdpfehSMOFTzBgSxfeo
X-MS-Office365-Filtering-Correlation-Id: f4184c21-3676-4949-ba00-08d5bfedf7db
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 14:11:52.1038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4184c21-3676-4949-ba00-08d5bfedf7db
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1375
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/2018 12:28 PM, Borislav Petkov wrote:
> Use a prefix for the subject pls:
>
> Subject: [PATCH RESEND 1/2] crypto: ccp: Add DOWNLOAD_FIRMWARE SEV command
>
> or
>
> Subject: [PATCH RESEND 1/2] crypto/ccp: Add DOWNLOAD_FIRMWARE SEV command
>
> or so.

Okay.


>
> On Wed, May 09, 2018 at 11:18:27AM -0500, Janakarajan Natarajan wrote:
>> The DOWNLOAD_FIRMWARE command, added as of SEV API v0.15, allows the OS
>> to install SEV firmware newer than the currently active SEV firmware.
>>
>> For the new SEV firmware to be applied it must:
>> * Pass the validation test performed by the existing firmware.
>> * Be of the same build or a newer build compared to the existing firmware.
>>
>> For more information please refer to "Section 5.11 DOWNLOAD_FIRMWARE" of
>> https://support.amd.com/TechDocs/55766_SEV-KM%20API_Specification.pdf
>>
>> Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
>> ---
>>   drivers/crypto/ccp/psp-dev.c | 96 +++++++++++++++++++++++++++++++++++++++-----
>>   drivers/crypto/ccp/psp-dev.h |  4 ++
>>   include/linux/psp-sev.h      | 12 ++++++
>>   3 files changed, 102 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
>> index d95ec52..1c78a2e 100644
>> --- a/drivers/crypto/ccp/psp-dev.c
>> +++ b/drivers/crypto/ccp/psp-dev.c
>> @@ -22,11 +22,17 @@
>>   #include <linux/delay.h>
>>   #include <linux/hw_random.h>
>>   #include <linux/ccp.h>
>> +#include <linux/firmware.h>
>>   
>>   #include "sp-dev.h"
>>   #include "psp-dev.h"
>>   
>> +#define SEV_VERSION_CHECK(_maj, _min)			\
>> +		((psp_master->api_major) >= _maj &&	\
>> +		 (psp_master->api_minor) >= _min)
>> +
>>   #define DEVICE_NAME	"sev"
>> +#define SEV_FW_FILE	"amd-sev.fw"
> Can we put this firmware in an amd folder like
>
> 	amd/sev.fw
>
> or so, like we to with the microcode?

Yes. I can do that.


>
> /lib/firmware/amd-ucode/
> ├── microcode_amd.bin
> ├── microcode_amd.bin.asc
> ├── microcode_amd_fam15h.bin
> ├── microcode_amd_fam15h.bin.asc
> ├── microcode_amd_fam16h.bin
> └── microcode_amd_fam16h.bin.asc
>
> It is tidier this way in the fw directory.
>
>>   static DEFINE_MUTEX(sev_cmd_mutex);
>>   static struct sev_misc_dev *misc_dev;
>> @@ -112,6 +118,7 @@ static int sev_cmd_buffer_len(int cmd)
>>   	case SEV_CMD_RECEIVE_UPDATE_DATA:	return sizeof(struct sev_data_receive_update_data);
>>   	case SEV_CMD_RECEIVE_UPDATE_VMSA:	return sizeof(struct sev_data_receive_update_vmsa);
>>   	case SEV_CMD_LAUNCH_UPDATE_SECRET:	return sizeof(struct sev_data_launch_secret);
>> +	case SEV_CMD_DOWNLOAD_FIRMWARE:		return sizeof(struct sev_data_download_firmware);
>>   	default:				return 0;
>>   	}
>>   
>> @@ -378,6 +385,77 @@ void *psp_copy_user_blob(u64 __user uaddr, u32 len)
>>   }
>>   EXPORT_SYMBOL_GPL(psp_copy_user_blob);
>>   
>> +static int get_sev_api_version(void)
> sev_get_api_version()
>
> like the rest.
>
>> +{
>> +	struct sev_user_data_status *status;
>> +	int error, ret;
>> +
>> +	status = &psp_master->status_cmd_buf;
>> +	ret = sev_platform_status(status, &error);
>> +	if (ret) {
>> +		dev_err(psp_master->dev,
>> +			"SEV: failed to get status. Error: %#x\n", error);
>> +		return 1;
>> +	}
>> +
>> +	psp_master->api_major = status->api_major;
>> +	psp_master->api_minor = status->api_minor;
>> +	psp_master->build = status->build;
>> +
>> +	return 0;
>> +}
>> +
>> +/* Don't fail if SEV FW couldn't be updated. Continue with existing SEV FW */
>> +static void sev_update_firmware(struct device *dev)
>> +{
>> +	struct sev_data_download_firmware *data;
>> +	const struct firmware *firmware;
>> +	int ret, error, order;
>> +	struct page *p;
>> +	u64 data_size;
>> +
>> +	ret = request_firmware(&firmware, SEV_FW_FILE, dev);
>> +	if (ret < 0)
>> +		return;
>> +
>> +	/*
>> +	 * SEV FW expects the physical address given to it to be 32
>> +	 * byte aligned. Memory allocated has structure placed at the
>> +	 * beginning followed by the firmware being passed to the SEV
>> +	 * FW. Allocate enough memory for data structure + alignment
>> +	 * padding + SEV FW.
>> +	 */
>> +	data_size = ALIGN(sizeof(struct sev_data_download_firmware), 32);
>> +
>> +	order = get_order(firmware->size + data_size);
>> +	p = alloc_pages(GFP_KERNEL, order);
>> +	if (!p)
>> +		goto fw_err;
>> +
>> +	/*
>> +	 * Copy firmware data to a kernel allocated contiguous
>> +	 * memory region.
>> +	 */
>> +	data = page_address(p);
>> +	memcpy(page_address(p) + data_size, firmware->data, firmware->size);
>> +
>> +	data->address = __psp_pa(page_address(p) + data_size);
>> +	data->len = firmware->size;
>> +
>> +	ret = sev_do_cmd(SEV_CMD_DOWNLOAD_FIRMWARE, data, &error);
>> +	if (ret) {
>> +		dev_dbg(dev, "Failed to update SEV firmware: %#x\n", error);
>> +	} else {
>> +		dev_info(dev, "SEV firmware update successful\n");
>> +		get_sev_api_version();
> Call that function in the caller of sev_update_firmware() and in its
> success path. For that, make sev_update_firmware() return success/error
> value.
>
>> +	}
>> +
>> +	__free_pages(p, order);
>> +
>> +fw_err:
>> +	release_firmware(firmware);
>> +}
>> +
>>   static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp)
>>   {
>>   	struct sev_user_data_pek_cert_import input;
>> @@ -750,7 +828,6 @@ EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
>>   
>>   void psp_pci_init(void)
>>   {
>> -	struct sev_user_data_status *status;
>>   	struct sp_device *sp;
>>   	int error, rc;
>>   
>> @@ -760,6 +837,12 @@ void psp_pci_init(void)
>>   
>>   	psp_master = sp->psp_data;
>>   
>> +	if (get_sev_api_version())
>> +		goto err;
>> +
>> +	if (SEV_VERSION_CHECK(0, 15))
> That macro could use a readability improvement. This way it doesn't tell
> me what the check is doing. Is it checking whether the version should be
> 0.15 or should it be bigger than 0.15 or what...?
>
> I have to go look at its definition.
>
>> +		sev_update_firmware(psp_master->dev);
> I wonder if we should try to load a new fw *every* time we init the
> driver. I guess so... can't think of something speaking against it right
> now...
>
>> +
>>   	/* Initialize the platform */
>>   	rc = sev_platform_init(&error);
>>   	if (rc) {
>> @@ -767,16 +850,9 @@ void psp_pci_init(void)
>>   		goto err;
>>   	}
>>   
>> -	/* Display SEV firmware version */
>> -	status = &psp_master->status_cmd_buf;
>> -	rc = sev_platform_status(status, &error);
>> -	if (rc) {
>> -		dev_err(sp->dev, "SEV: failed to get status error %#x\n", error);
>> -		goto err;
>> -	}
>> +	dev_info(sp->dev, "SEV API:%d.%d build:%d\n", psp_master->api_major,
>> +		 psp_master->api_minor, psp_master->build);
>>   
>> -	dev_info(sp->dev, "SEV API:%d.%d build:%d\n", status->api_major,
>> -		 status->api_minor, status->build);
>>   	return;
>>   
>>   err:
> But, before we do further games with this, I'm able to trigger the
> following link error with the attached config. So pls sort that out
> first. The idea is that the user should not be able to create a failing
> config.

I have submitted a bugfix for this in the KVM tree.

I can send out a v2 of this patchset with the required changes.

Thanks,
Janak

>
> arch/x86/kvm/svm.o: In function `__sev_issue_cmd':
> /home/boris/kernel/linux/arch/x86/kvm/svm.c:6256: undefined reference to `sev_issue_cmd_external_user'
> arch/x86/kvm/svm.o: In function `sev_unbind_asid':
> /home/boris/kernel/linux/arch/x86/kvm/svm.c:1740: undefined reference to `sev_guest_deactivate'
> /home/boris/kernel/linux/arch/x86/kvm/svm.c:1743: undefined reference to `sev_guest_df_flush'
> /home/boris/kernel/linux/arch/x86/kvm/svm.c:1752: undefined reference to `sev_guest_decommission'
> arch/x86/kvm/svm.o: In function `sev_guest_init':
> /home/boris/kernel/linux/arch/x86/kvm/svm.c:6207: undefined reference to `sev_platform_init'
> arch/x86/kvm/svm.o: In function `sev_launch_start':
> /home/boris/kernel/linux/arch/x86/kvm/svm.c:6302: undefined reference to `psp_copy_user_blob'
> /home/boris/kernel/linux/arch/x86/kvm/svm.c:6290: undefined reference to `psp_copy_user_blob'
> arch/x86/kvm/svm.o: In function `sev_bind_asid':
> /home/boris/kernel/linux/arch/x86/kvm/svm.c:6230: undefined reference to `sev_guest_df_flush'
> /home/boris/kernel/linux/arch/x86/kvm/svm.c:6241: undefined reference to `sev_guest_activate'
> arch/x86/kvm/svm.o: In function `sev_launch_secret':
> /home/boris/kernel/linux/arch/x86/kvm/svm.c:6833: undefined reference to `psp_copy_user_blob'
> /home/boris/kernel/linux/arch/x86/kvm/svm.c:6842: undefined reference to `psp_copy_user_blob'
> arch/x86/kvm/svm.o: In function `sev_hardware_setup':
> /home/boris/kernel/linux/arch/x86/kvm/svm.c:1237: undefined reference to `sev_platform_status'
> make: *** [vmlinux] Error 1
>
> Thx.
>
