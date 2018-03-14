Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeCNWXr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 18:23:47 -0400
Received: from mail-sn1nam02on0088.outbound.protection.outlook.com ([104.47.36.88]:64766
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751279AbeCNWXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 18:23:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v2 1/5] iommu/amd - Add debugfs support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
 <152055664720.63229.16209149030018336339.stgit@sosxen2.amd.com>
 <CAHp75VdK6qFopBE4rD4yNO5GHccxyte=GhYU7YGcWOEYSCyX8Q@mail.gmail.com>
 <30bd9559-0e44-bd18-6b9a-ec35bc8276f3@amd.com>
 <CAHp75VeySPBEeJKRXzmqfPey56J3rwr2-dPRzSYx+7a7TAC5rw@mail.gmail.com>
 <08d19301-7e8e-7586-8ffb-91823af0d31b@amd.com>
 <CAHp75VeEUCVSKLH0aobk=+GjVHWgO_OAKZRCx8gqDc9tWvESMw@mail.gmail.com>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <e43c5e45-77e8-df20-ee90-1ac5cc3ad288@amd.com>
Date: Wed, 14 Mar 2018 17:23:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeEUCVSKLH0aobk=+GjVHWgO_OAKZRCx8gqDc9tWvESMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CY4PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:903:152::13) To SN1PR12MB0703.namprd12.prod.outlook.com
 (2a01:111:e400:c42a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c793e3ef-a014-4780-a72c-08d589fa3f51
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0703;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;3:kPVJwCngu60DkG9U6AvU+hhX03tr46n1J/DAYvy4R6C/lnj/UUjY7zpFig0hVIIKCWpeJEaZvhx6WCnQX8BCKy7ZDKViRR4nWc8/5bxYMt6clY3TvR/1CuG/S+KOhKxc3U8N/pnOWTO+ifcuRpS57qfNxkRf5J+L1/tzRoJuEk8MWEzHSO0tZTT63E2Hz3JjvlHKp+gONX8e1gY5E8PItzd+eCYoMNdzNfsvu+J20hxt3Lu16QQb4mTE3KaQa0Cc;25:qu6Us93QvL8wWkr3KbAInJCxbVO17MOj3xGz7B84IwP3aBcrDVB8oD+2X2JwKsi16pVf2pSfkdtpPXBUnJqVku7ZHG7r5OhNx4YPDlo/IiCmTgZBhD7Ywhb4tk/y7FMh82he1mtAniU+RhBy3a24xRjXe6T5M9USX95SI8F+aDRM6/5noGejpz8h0OOnJht8gYcRhfCI8k0plFjUH9oySJkwjvd+5nDZ0UhEkgZrgFu6IyiwGXW/6e5OA19uxvgB58TylxvWp23r6Y0prv7NGGA627tfphQtM8ISJujUeVy+QLPPJY8wRGblADgCitoPEfKWlioCggaCHIUn58yYtbaHANwmtTaGOR+aise8CUc=;31:M8KLVyPXhW1BhexMi0LKnsXwAzwj5Mtybv9gyvQ0SFKVDCyFUg1miBKmzxl0tqHcZRco51K/whRZS5TlCoydbyEdIqw1O8jyxc9z4n21wldl26qVM4HpSh/bhDiYiOUcd0AcVVYs/vK7PMfHzUh7k2BMWpkl167YhQFWue5xPXUfkFFCur7befNPAdx0A1sKu2wpUqvaRrMua5ne4IhEmpgafTdr3BxWyUVgTAwtX0s=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0703:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;20:N+6BF+A3oOAlIdAEROD6p4hkCTW6IXKFItFwVPAigeKNDrWEUsChOkJ/rOy2S4uNgCWl6b4FFStTvk4VEPe+ej/Ega9pk6bWPVVuLQnqBb9wHpfPFZ7Dqm3HziMDwHq4Rlmk6V+C6nPTqgSMoW33+7Eo5FUt4NndeNsEDTeIHtwbFetIDRWpFob9CRHk2V2QEx4fQE2s+SU4GyPqME+WLHWMWgGQrPCkjv7yd8wlA+GdC7XMUAok6FZX3EfGrllRCRlnHQPlF/H7Md0THCPD+v2BqqsaQ6Q7wSSxRuUxVqUPaPqw8pwQqXU3Epk8a6ub59sDpmatGUxconBoRga3z/zbceT5f1y9Pb37iUxRncH41wdYfWRGLSBaWNj4RusVWs+ll3iKfMj8WEWGwbzXMyfKKvOqR+uNCroVLnyQ+2rHcRakEZNJ3dXo73Z+sG1frmWPWcZDvxQtdCJ5bCkMjjuWAkE6fYVfEtGf2BpzloZT7PRSdgYxufWxm23NWAsI;4:CGDbQS5/5XFT5dRTr7aw/+9BTYU2rkbTmkiQtBGAOe8Nuvj1eQm0qyigCowHRgLPrSIV7bXqYvzbcf0jeTWa9otoYQzILkNWDYHMHnw6teLOSzRDtI/pcElXUVcAhsPbn9jreWYzQ1jbnh/T9ODy5Kui9TCiqkuV0kLwq7spC9rwWiZqt69rMwBH8nGMPpzWv1Ux8NHOPVtojcX/+MuyKxkHJU3Yk93CtZ4FAZUg9w8k3YROTYHf/tCc5HexvqNhmuo9+jHpy/nrX4uTRxTyFpi9IRJlTAmu8alGP63aSQitJztZqcSeEy0+U+E0/Lxv
X-Microsoft-Antispam-PRVS: <SN1PR12MB070395234255BFC39D86E3D0FDD10@SN1PR12MB0703.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:SN1PR12MB0703;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0703;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(376002)(39860400002)(366004)(396003)(39380400002)(189003)(199004)(93886005)(23676004)(105586002)(65806001)(16526019)(76176011)(52116002)(53546011)(65956001)(36756003)(7736002)(47776003)(68736007)(66066001)(186003)(58126008)(6246003)(316002)(305945005)(77096007)(26005)(16576012)(64126003)(2486003)(54906003)(59450400001)(52146003)(65826007)(386003)(2950100002)(25786009)(4326008)(6116002)(53936002)(6916009)(3846002)(8936002)(31696002)(5660300001)(106356001)(39060400002)(72206003)(229853002)(50466002)(31686004)(6486002)(86362001)(230700001)(2906002)(97736004)(67846002)(8676002)(81166006)(478600001)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0703;H:[10.236.109.62];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNzAzOzIzOm5KZjZiMkpyYTNYZjczUnNGRFUyOXgvWEM2?=
 =?utf-8?B?UHhzbG5DNTRDYXN2Zzc2S0lYdXlHNlVocVU0Ty9oeEtrb1R6NkFWTENBT1RK?=
 =?utf-8?B?R3Z2bTR4Z2RPSSsvQ1lKU2RlVUs2MERIM00ybFlMR0FwVktMa3doQi9sWTdq?=
 =?utf-8?B?S3dwSW8rUXZUREFhci9QZDVWSHFrSW9sSk9CNFVOL1ZTK3NiRHk0QWsvelVJ?=
 =?utf-8?B?Yi9vMm9nWVdjbXQ0OUNUeDQrVDM2SGRGdDVmN2hpQ0lrbCtoblNaRFVFR3N2?=
 =?utf-8?B?eS9jRTZzSnJla25OOHREYWtSRUpOaHRXTFozNXhsNXZlME1Ib1JTQm9TQkx1?=
 =?utf-8?B?dUZBZEpMbThxMmNDNzJqenA3dEt6MEh5MEdqYjZpeC85dkxTVno5R0gzeHlk?=
 =?utf-8?B?Q3lBa2VlTXBGLy9oWTlNWEhHYVdhdUhtTVVoQkNHYUlJR0VwS3d2NkowUjB1?=
 =?utf-8?B?RnlGVUUwWXBDcWZScjVEU25iQlg4U1NrYVhUQ2lMOGVzSFpvT0JyczNybDdz?=
 =?utf-8?B?dUtRVmo5OTFYTERtZVM4REJkbVBtVlFraFdZNjZEelNubVJFNDFxRjlvb2Yz?=
 =?utf-8?B?S1dEalh1YnVvR1Blc1BmaTNKUTBtTmwxZXVybXBQRUEwelhuc0x5S3ZVYXBl?=
 =?utf-8?B?NTJvbW95MllHYzFpQVYvajNrTERabXBjOHU1Njk5RmVQUXpqWlZKc1JNeFJv?=
 =?utf-8?B?MFVpaDY0cnZxQ2RxSC81eUYrVXpqZ3ZOQ3M3SnhHOW8zZlRMT3FEdTY2NURk?=
 =?utf-8?B?RytCbTFYM0tSdUNNekFob2tJMWVWcWN1eEozNGMzVHNkT2p2NGgxcFJSVlJN?=
 =?utf-8?B?UERFYWE5d0NIdW9SQitHaUJpUS9ac0FUeHhkSlI2dzZqODJ0ZXZqUHdxMW5Y?=
 =?utf-8?B?Z05XOS9iSWxnZG5BYlFXVzBZWHVMK3dTWHU5VUM2VFpwWGYza0hZTHNHcG8z?=
 =?utf-8?B?U2hmTVVwRFhNUk5vYTNqck0wV2M5TWorV0s5elRDcU5tYTJ3ejF1WHpKVFRE?=
 =?utf-8?B?cFlGUWtKNFNNN3lGTndIRmQybVBmM1RHbHFVcTdLbUM5RkxKZ2RiUHFBd2NK?=
 =?utf-8?B?YWl1K2pDZExsVEJIaUlLdUJtMkVwa3F0WU1SUzg0RitEMjVLMlFuMHpDYWFE?=
 =?utf-8?B?VjZEa2pKSXVKcCtmOFVubnhablJKZnJxZkFWMjFZRnpvRk9ybWw3eDBGS2Vu?=
 =?utf-8?B?a3VHUllZSXlUSm9YeDlhR3JOYldiNG9KZlo5cnFjclBzbFpZRDZNTmN6Qzl3?=
 =?utf-8?B?R3F0UE5CWDQ1aW1FeExWWVVRbHAxSWhXdEUxd2kxS3V1RS9NK28vWXVqelNG?=
 =?utf-8?B?bVkrL0VCeTRGcm1zcytENW94MVdPK3B1UnJhOFRxWUJmZXBSL1Q0UVhYM2Nv?=
 =?utf-8?B?UUVDSmxoVnZYYlBjanlocEJwZXRKNVB2S2xxampPZmErUFdQbVpMOWpWQWI5?=
 =?utf-8?B?cjVvdHpkTFhacTJWOGgzZktmd1VQTXJPQW51RlI2YTd2Y0V3WENudjg0Q0VS?=
 =?utf-8?B?cEltU1FYN2lZeEFJelc3aFVYLzRqdStxZG5wOU4yVkdqV1pxWWZrVFZXY3dT?=
 =?utf-8?B?ODh2SzNBSVZJSmtmYjIyZmFBcnZtNFR5QzZyMkV6SnJ2dFluYUgwY3h3YUlK?=
 =?utf-8?B?YmJGU3NFNkN4ZjZhNTM2UUdBSlkwY0JPa25LdkV2WFQ3YWhJN0hySFU4blZi?=
 =?utf-8?B?M3VVRXI3d3FCNURCVWpSYXNlNTRKOW93VXVnUnBGa0VPcmFMOFhPUEFpZlpB?=
 =?utf-8?B?NFFtNTZQZTBmajNmV2ZIMkNBNjN3UmhBMnp4WGFuVTJQenVvQ1VwM3ZpZnZD?=
 =?utf-8?B?c3BvbTJQM01qYjdBQzl6WDFPZ0swWDBGVGkvQ3g0Q2V6NWZzOHBxYTc0K0ZY?=
 =?utf-8?B?M1dnRDFRVjdlVS9GM0Fmek1Jd3RxSndkMHRtbXVwUENVQjNqZjR6TWlsZXNU?=
 =?utf-8?B?MWJUZkc0YngxTHFXeWhoN0dNUGNBRHhlc0k5WlI0K1RIV25vK0tQNm56WVBH?=
 =?utf-8?Q?OiN16J?=
X-Microsoft-Antispam-Message-Info: 2UQDAMXVTDDjtJcrOK/cnWdr+pxZlRLGhwQXGHdMzAgpRb7tOaHPes55BNRIuKBfzDEKTNYhpo3LeWch0jvy4JuZ30HpyA9il+XKNv94aMO3NEoJT0SllHMMEUqwWjCoGkQnKCNVy55imfUjy2O7Ln7xRnVRxGYj2Uidrb9WaBBxDeX3lJQ0emtQbJUh4V39
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;6:u76dPTwRgHbLFOAXhj7DqVG9Ei9CQDCb11T5YXmyaLYnFFKcLQe4CrLvSb2w14m5wPRH7cfla0TcGvblGnCn9gRzPGv5GCvFdHC32EVLbD/uTGyjaemuQsvpUanU7gbFhzg7v0CqCbtK4HhsLM2mRQ2qr22Wdtxnra8YoxR2t5TAIr0wmw0PeX+E2pqq8up05JKgW+jSybdF9COrRxgUs9toXI23mdjsbURqusxPQTSzcy5+/AmCXfY2bFLfBkQv9IQQsHZbYx/KmsHc/0DdrsgCAwHjC5S3925QUFMAsZ7yC7+/q7BU5fVuC6BVu/ISfBRkcuVeog5BQXVt6pWAJuwtosssrtvPZt2aYlcjRog=;5:Lc4HTr0jziZhQPYqH95fmCiLc122x2KDfBrHvP2j/d13Q/uOqDg7Ga+I87tR74vdEyfzvBFy+eFWPp/EUP91bbO5sg2w+Dmt57ZGOFaLiBvUWdqSYKG4jZAOKYVK6sBSVeRXcCGJsnUuikn47G1XEkzVcKfOYyzBahcjpIaj98Y=;24:ookiceNPjAqnhZSinTExhoitHs5nNvfBtxlQN+vB1UGXDJ58p4NqHXm50nTvlkaMkps2mBz+5Qr/Vt9kr8OB3LD39lSHVnCW2rqRQc0VQbQ=;7:RQe6zpCnYZ7ZPWRyHbkPhY5dzU0pwWxXCj761FYF5NIGXYKlVjTEo9wm9ph30o5PCINPw1Wd2yzsI3ii/sGssYkHNfoWi7wXiJ4dDa2eQMuorWjkBV5NklVubfveUB84N27B8sF1o6bcy0QrpmlFMn9DB/ga0uXal9itIz9aFmpqMFY4SKp67lI0UmX56p7b+AQyKD4uZLBGxD658T5s/sZBLJlgw2XMXzodPEeg1yCIV5pSVLnZKSOro8tao0YH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;20:t+iUVZon/A732nMpXHVbZunGH1xQWb6DGR468qplpKj3hqZ+COk4Aqo0ke4AWHJbH6s165Wy7vo36YsTSfn/l9YJDKmiq0xwkR5Iq3TMeMXSRY0JfdIiAPII97lfT9nGj1fMWz+bMZvhtR3jUGLN+pd8rgzeDvayG4O/DFQ2goORPNrleRkRWgV5x0wDWFOcJaN58Q7FkpK+Ef7H9mKEa/je301eI0fn7s0sjgZx0b/W+w5RVqSiYmACvvGqMcJb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 22:23:43.6188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c793e3ef-a014-4780-a72c-08d589fa3f51
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0703
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14/2018 10:29 AM, Andy Shevchenko wrote:
> On Wed, Mar 14, 2018 at 5:24 PM, Gary R Hook <gary.hook@amd.com> wrote:
>> On 03/13/2018 03:23 PM, Andy Shevchenko wrote:
> 
>>>>>> +#include <linux/pci.h>
>>>>>> +#include <linux/iommu.h>
>>>>>> +#include <linux/debugfs.h>
> 
>>>>> Keep in order?
> 
>>>> What order would that be? These few needed files are listed in the same
>>>> order as which they appear in amd_iommu.c. I'm gonna need a preference
>>>> spelled out, please (and a rationale, so I may better understand).
> 
>>> To increase readability and avoid potential header duplication (here
>>> is can bus protocol implementation where the problem exists for real,
>>> even in new code!)
> 
>> With all due respect, I don't find that you clearly answered my question.
> 
> Alphabetical order I meant.

Thank you very much.

Gary
