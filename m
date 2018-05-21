Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeEUNXX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:23:23 -0400
Received: from mail-bn3nam01on0044.outbound.protection.outlook.com ([104.47.33.44]:59328
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751054AbeEUNXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:23:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 0/2] support kdump for AMD secure memory encryption(sme)
To: lijiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, dyoung@redhat.com, bhe@redhat.com
References: <20180515015133.4363-1-lijiang@redhat.com>
 <55bda494-bee4-5696-03e5-fc21c9d6b631@amd.com>
 <18309611-c8c4-92cb-161e-f35ef3d243ea@redhat.com>
 <a0b95743-209a-aca7-33e4-828375df1826@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <3972e681-d8eb-4f4d-843a-6ddbf339f0bb@amd.com>
Date: Mon, 21 May 2018 08:23:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a0b95743-209a-aca7-33e4-828375df1826@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0201CA0013.namprd02.prod.outlook.com
 (2603:10b6:803:2b::23) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;3:fLHL9NrCwDc0WFxHr1koHp/xFOa6TvTzO2F6DNRzpBKVUhsrjqCNdQtgc/dbH6pRnrKqGczkcKv/Y2r0k+UbX6lGEtqX96J9JX5ZuIA5JOC5fwgOZTYHo8aezPYyORPnMS0BlvQ1sACVvc7bG/n7s4O2GbmRHQyiNaL/+ymSxVXPENSfmDKvR5POyqDrcq3ohlAhbnCkn4E3syJ9rbLnzpkQos4u0XUB4HvdWjMAqFzKTbSO+3UOGA7KDD+jfpit;25:1zoPiN44VShqWVUapbSRIG66Oc4gfWbg4Qn/X2kjZaw+QLJ52eOVrm/TR0qM6HxTHKWimCNCa7iFMVHnmlt0BttMhjp6nbf3SwVRNAU8M/88HJj2ioSFS+Cm9yfQfwV9qbbMSf9nh/Cui9+yVY0+x2ZQV19LVU2aF6U8PW/p5b42Kwt3YXs27Ax+3yb6kKVBtrfGOEk141395Dz6tDegXubAkT2vqQvozIeeyUxiUvMbXrkCkvM51I9m6AHZvfZdiGftmTX/ZhUpnNOHGpo2hORoYVYbAhlJS3dhgP3q92LNzntg0FDF+4tVZCrYr37tlPdb2raqPcmviPvUtEts4g==;31:gVzmay1auyPhUz+HTsLPqmjUZbUE/v2Wkd3jGiq0wSUPkZUmPjofy9SySyy6I0+i03BeXbdv6ue+3KBNksiJo7nAElvdUmJT1xdnyGEiK0GcUWcq1GWF+rGQa9lBDIR/kuPMHTPLqgZxBcBz7K7qBzgVpsWvTWEx2Gj1PoiDDMyYIJy6rEnBtlib0f6Kn+uJpsivCKRRdk2FtrlVd0n59WSCYsjssrRXYvUMia5+a5g=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;20:DPnQH6c7ZS0tn25wW7nowV97a4UIZdrbaeur0TOKKrBAISPsqdC4sSQwRqapFvNVgE790RyiNEbrWXjAsx8oN0P3dGqM5i/HllEuyaRY5YCsGjinGbjzT8jTh7cxGQWvPxb/oIGae896xB36jP7Y8Th5EHX677ZatjrdmpH9qioOjh+uhX8Y4jsfp3o6JR6gpJoWRbNjvb7J0NABR+Y1Zoh/zIPHwuHL+2qhIgISNoQYO5jUS+nWwHY6++AfiOiRUweWjFn2y6sNp8eRfTbT4etYHeqOPVeqALn/Lm8NaRfvd39fKX4OtqroEkbfbLovbL/D0UQET2OGWbOJ73rIBEyJ4agOG6MjBum8vT/Ba3Z2sIdExxgugwpLyChkom4jXq87m5Xnu3dw4M5N5rzOsStGXCGl7iRxtmjYhNmi8FwKsEHN92tLdrMu9T0IsLY+ZeQRevmtn5Rv1Mu/o1dbEWc8QojZsjiss0k2elovkI/52QsIwGOTEBa5J989MOAl;4:rgtaUerm1iXgI6J9J5nGh6Ddd+CakfgxBiwXyMx008di7p2j0f+u6ygJHYop6R+py3+ic57ZlkiVG+JkcCLvD7QIIOKzUL7KTGMhQ+n/6KXMIvnnyOTZrXwk0ajJq4iPQqdQe2jlUr6ORDW4KNPjAjL9n+T7GARvvNDM62dXtLwaEZ6nbbn7n/WoEToYlFAHFobJsnutmf41L8LXz/yP14U0sOWIgy9YqDT9FwTtH9YBBXLn+shwiH8sF1HKmqgFu7UnD9NO8AvKuJO6t35uTWMo6pjBvb2wWqQA3Rpopj5AJBvS3sa0oPjF+uX90i7Xon8FZ7zyeR0IID/Q2bsojmN3CzFMOff55Jt5MY4AQqddnpyldaoRBejrciOLgZoRq9TJEhxPzWmn9INqerj+kfWtA7wrcRmqUF2sg5PiFwQ=
X-Microsoft-Antispam-PRVS: <SN1PR12MB01759EC73605F1F4D1D6F48CEC950@SN1PR12MB0175.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(166708455590820)(767451399110)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0175;
X-Forefront-PRVS: 06793E740F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39380400002)(39860400002)(366004)(396003)(346002)(189003)(199004)(31014005)(3260700006)(25786009)(97736004)(966005)(72206003)(3846002)(6116002)(478600001)(50466002)(4326008)(53936002)(65956001)(64126003)(65826007)(6666003)(5660300001)(6246003)(7736002)(229853002)(66066001)(65806001)(6486002)(305945005)(47776003)(53546011)(59450400001)(26005)(386003)(36756003)(77096007)(76176011)(476003)(2616005)(11346002)(486006)(16526019)(186003)(52146003)(23676004)(52116002)(93886005)(68736007)(2486003)(105586002)(2870700001)(316002)(81166006)(16576012)(956004)(8676002)(106356001)(2906002)(81156014)(446003)(31686004)(8936002)(6306002)(31696002)(58126008)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0175;H:[10.236.64.67];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMTc1OzIzOm1oS255RUVkVVFwSEZhSUNsaEptR2cyVjhq?=
 =?utf-8?B?bHJMNkhRUzRINWRROW1MaUsvRzJKa3o4RTZxaDA4S0oxKzFaa0JwMmpIRzYr?=
 =?utf-8?B?YlVVM1BOUW9DVFdpZW0zUUZmd2I0Vzc4ck1sT3NNMDE1L3Y5SUZkSXNaOGZ6?=
 =?utf-8?B?VmdFTTc0WFZwSXJOYWVkcG41TEErNWhQVHhTbTdEbjU3bWxPVW90bkFoUndm?=
 =?utf-8?B?UmNaZDZFcmgremJ3eWUzQXVTNnV2eTIxOVI5MCtQUWVkZXZ3aUlQWldyNFp4?=
 =?utf-8?B?MEcrdE1sdDNNR0gzYjlwM3VYcEVaR2JmZkR5YUZHNzZ0TkxZdmorNDhYYk1U?=
 =?utf-8?B?THRXbjVQVGVEaWJBNE1zRTJjTUY2UU1iZDBjQ1hpR3hwYW5EZGZYRGJaa3Mx?=
 =?utf-8?B?VDFTcWhsQWtLNTRDdFlLT3d1YjJ6UHBRVHZuZ2wwVUNDUVZxcG42aDI1Qy9O?=
 =?utf-8?B?MGNaKyswSDY1VzByQ0lZc01tTU5JTUZyY1l1bHVoYVBqMGcyNVlwUXF6UUhL?=
 =?utf-8?B?cDRHMkJrdGFXY21NcG02UFFGWnAvZ2RYT2dUTXZuQkxtVHhiTzhydE93M2Ru?=
 =?utf-8?B?cEdQaWRXU2haNG9qMFp0R1Y1dk5maVFibkM4UVhsam13TlVNMnUrYkxpazNP?=
 =?utf-8?B?K3Nsc1NKd3JWcVRFSWNnMVlXaVpWNWdDQm1lc043Vm1kTnE0SEcyblNaWXlu?=
 =?utf-8?B?S1lVdWFpU3BCTWFwMHg2MEVtMmpDWTV6dHJIRGtpS0VCNGsvUFY5QkRhMTFw?=
 =?utf-8?B?b1dqUUNOY0J6NTNPOG9BRzM5TnF3S0lmYXJBWkp3clN2NDQ5WUtKM0o4aGJE?=
 =?utf-8?B?c3FORUlTL3BFWUVCSnFvSmJqc3hMaEM1SVBEUTJFN081di8raU8vR0I3TzJH?=
 =?utf-8?B?eHRXVG9lUXdYS0E5UFVEUTZiQzZwZHNOYlhBem5OQnBEZXJqbGNsb25DS3Y0?=
 =?utf-8?B?SDRKUDFUUkxoeG55YksxK0VjT0pwc3cwMW9uZGIxenZvSm0vNVVKcVlnamtI?=
 =?utf-8?B?RUNWcnNZNC8vMkRrYnFXcHgvM2FWY0lQUm1TbjVQTS9FLzMrcjhvYUM1aWJF?=
 =?utf-8?B?NHFKRnFiTkhDa2hrUThhMlpkY3NuVW1nWkJwT3R5TEoyMDdJaCtCQ0g5aUtm?=
 =?utf-8?B?empBNHlBenErL21tbDByRUZkaWtJUXZzLzlUZlNJU3ZJVnM4aDFNcDZIMkds?=
 =?utf-8?B?cyswcWFiYWh5VEFERmhLQzJuMS9yemJIMTRBb09RK1AvWVY4SjZxbHJoem5X?=
 =?utf-8?B?d1o4cEFZaEdZL2tmdjVWQjRKRVo1RXkxMUdvZHhQbnJTYks2WjBYZkFkSWpH?=
 =?utf-8?B?dmphRnZadkNDK1ZIaGJHMkp5VGs0QUlmNDJvL2U0Y0gwZ2JFdTJFNEtueXR3?=
 =?utf-8?B?dGZ4b1UrcUdLd01aY2JKRm5RSDBGU1F6czVTTFF1ZG55dW1GTTRQRkxqOWxE?=
 =?utf-8?B?c3lEanFEN3h3NlNMQk5KWTA0NjBYaURMbkRwaE9teVFvS2kyYjBBejVLRGta?=
 =?utf-8?B?eVlwcFlFWXVneXdGY1A0VjJ5ZFR1SkJ6MENSTEhYQzcvQVlKeUNEOTYzRlU0?=
 =?utf-8?B?eUJWR3g5T01zZlVRNy93OW5MYXdoSThmRzlwSTZ5Y25lL3FFYlNwcUQ0SlFo?=
 =?utf-8?B?YW1LU3JVQ3BIWjNzcmI2YzRndGNMcm9mRCtzOTByUU9KSWVmb2NtcGU3QURa?=
 =?utf-8?B?VkhwYVZIUGhJVGJoakczTkNTdURRVStSVEJ4NFVncHJFWGtoM3F4VjBlK0k0?=
 =?utf-8?B?ZndoMHZ6SlplSmthTUVuNitubi9DdURLL21QWkxOYVZJRG9QZ05BYjlyZUFl?=
 =?utf-8?B?bG5rUGZHVjg3YnBZd1JremJSNSt6cFYvQm50eWE4UlhYbC9HVnpyNlM5bWtr?=
 =?utf-8?B?UVBTZzNDRUdOSWFFeGVXU2xnbzRCdURKekR6V1YrU3dHZXhPc2xOa3U4dCto?=
 =?utf-8?B?Rjk0UDlwSmVuMkJoWE1lNXZhYVc0OHp0aXpIYjB5Qkd0YjFISWt6bUVQZjdH?=
 =?utf-8?B?V0JFNUwwRFhnVm1aQjN2VVRGd2E2OUdsM21ZcUszMzhMRzdFeFd4VzVSd3RT?=
 =?utf-8?B?NEs1dTNnZHZxYytqbWlrVFp2NG82dThCZlk3dnBkbTdEQmxMQ2l5R0pGMTQv?=
 =?utf-8?B?NkE9PQ==?=
X-Microsoft-Antispam-Message-Info: yHPbdO1PD5PzR0U4cMxuw/k4hsLfG8Eu1R6D2YIDwK5Yn7YwjXXbu/Y+9zqQS5z1Fxm/oA3weNg3SNJ6gsGXZwFDTuzMF4T0Or3LibXmOV3G1qkX8PJTNcrnb2A5zzWqUAsCaMZqhUVHphgV+J28a7bqQ9VbnXHSOI0LEOFmV3Lcyhh+ygSqD3u+0bBbJ6UC
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;6:j2U6IN8fDoEiDTb72pnNlGk+NmSLF9oK30EX4/MrmHX5gn89PpbT4wSpT8+ldYsMq/LwXxaWS5GCU7yZf9jy8Thv+gc4XtdcTeDlhRDYLZEkfc2bAUL4EBSOuyrLuPLBLRqg61JmYb2OYPwk6zgHmCtiAUky8VZzFW6893CSNIBM688E8FJscn+9QTcNMhY2mc9/K5rPUnE5C1wTBvQM1R+1LPXkV53A7D5cweJiHqZc386Ef4+uHzu3ghCglWVliQ4Fgz94YagBRd3uuP5beCTfh9iIwze7k7yb206JDPQLuQoavI27Oezp+45nHpQq/WwzHtGRDqSw3ihvw3BnJk2xt5yOElrhCT9cv/VR4TNQonSlcctuMboCGwWJmlMKo6CcboGxrFJS16MIJleLbPQjusMmdIcIsPdSIX3c9MPi4QhKxfytNU3XIDvlqeE6HpUQUm+zz2yHRWrATLbaAQ==;5:jSoWztux9f6B93STEI82SYlhXNFciLzuejDyUOlzOhkZ5J4+dVdqAZ0p+cJjnPPlTuOoSarqcFlWvS/BzgVPZZmLtZ9r9dKJYYvzSt7NLSUlBS5fCsMJHS6vU95jCnrvs+dWU6tpFovFOQ97+NaSeVUL3TYNU3Jb25nQ/iMW/pM=;24:8oKVD8b7UzawwDkcDVLgwT3hEY/TwK4CjopaM4vf2A92gPtountoTpHXgU5ZwpGsp44r2SGcNQDjWt4BTvgh0OqBJRr/myvMY2z2/m2gu7M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;7:As4qYX0rv7fP2XNE36nqXjO3RWgUTtEKdL1g/gv86ptVPwcz3R3u6Y0RnEOwSvNNRaCV4dMdXjx0g5YGbYuumU/4WIt5GHyRMgNisQ/FZvicmcpWq4wPzF4HjUjxvGgImg+F3+w/Y52wTRp3RmbcwV6MFWSI4/piwtItu0Bu5+bYyt++0M88wdGjDSJlhQv3KwCZLSqlkHPmk49TnSZNpHjh/7P3/euvc+jrD1ngHyDkhaundLEU3bx+7K2K69vE;20:3qZui40Z+gR6Hk1UPjHcYTr5C5lPWsBc0mGCntWn4IiKg61PN6grtIdMu8H2or5KrKucocW7qtrVYqyrZ/OwZaUE4uHnbc7LFzOsuFx3iKb0bGVYt17kp4CTzXwGo+GMWsgnEDh0QVSfLthDw/M0rUSWQ5wG9O1q0Poc+tVvO2dYZqQGWv7daYs6fpnAkBS5Pmh0kOmOR5/UhpHM5dYiRhe9ktAHuatPnSqTYo2t8V7I9FmY8pIaEtDzjUMjo4mb
X-MS-Office365-Filtering-Correlation-Id: b23fbdbb-e18a-420e-fb06-08d5bf1e0441
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2018 13:23:17.9150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b23fbdbb-e18a-420e-fb06-08d5bf1e0441
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0175
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/2018 10:45 PM, lijiang wrote:
> 在 2018年05月17日 21:45, lijiang 写道:
>> 在 2018年05月15日 21:31, Tom Lendacky 写道:
>>> On 5/14/2018 8:51 PM, Lianbo Jiang wrote:
>>>> It is convenient to remap the old memory encrypted to the second kernel by
>>>> calling ioremap_encrypted().
>>>>
>>>> When sme enabled on AMD server, we also need to support kdump. Because
>>>> the memory is encrypted in the first kernel, we will remap the old memory
>>>> encrypted to the second kernel(crash kernel), and sme is also enabled in
>>>> the second kernel, otherwise the old memory encrypted can not be decrypted.
>>>> Because simply changing the value of a C-bit on a page will not
>>>> automatically encrypt the existing contents of a page, and any data in the
>>>> page prior to the C-bit modification will become unintelligible. A page of
>>>> memory that is marked encrypted will be automatically decrypted when read
>>>> from DRAM and will be automatically encrypted when written to DRAM.
>>>>
>>>> For the kdump, it is necessary to distinguish whether the memory is
>>>> encrypted. Furthermore, we should also know which part of the memory is
>>>> encrypted or decrypted. We will appropriately remap the memory according
>>>> to the specific situation in order to tell cpu how to deal with the
>>>> data(encrypted or decrypted). For example, when sme enabled, if the old
>>>> memory is encrypted, we will remap the old memory in encrypted way, which
>>>> will automatically decrypt the old memory encrypted when we read those data
>>>> from the remapping address.
>>>>
>>>>  ----------------------------------------------
>>>> | first-kernel | second-kernel | kdump support |
>>>> |      (mem_encrypt=on|off)    |   (yes|no)    | 
>>>> |--------------+---------------+---------------|
>>>> |     on       |     on        |     yes       |
>>>> |     off      |     off       |     yes       |
>>>> |     on       |     off       |     no        |
>>>> |     off      |     on        |     no        |
>>>> |______________|_______________|_______________|
>>>>
>>>> Test tools:
>>>> makedumpfile[v1.6.3]: https://github.com/LianboJ/makedumpfile
>>>> commit e1de103eca8f (A draft for kdump vmcore about AMD SME)
>>>> Author: Lianbo Jiang <lijiang@redhat.com>
>>>> Date:   Mon May 14 17:02:40 2018 +0800
>>>> Note: This patch can only dump vmcore in the case of SME enabled.
>>>>
>>>> crash-7.2.1: https://github.com/crash-utility/crash.git
>>>> commit 1e1bd9c4c1be (Fix for the "bpf" command display on Linux 4.17-rc1)
>>>> Author: Dave Anderson <anderson@redhat.com>
>>>> Date:   Fri May 11 15:54:32 2018 -0400
>>>>
>>>> Test environment:
>>>> HP ProLiant DL385Gen10 AMD EPYC 7251
>>>> 8-Core Processor
>>>> 32768 MB memory
>>>> 600 GB disk space
>>>>
>>>> Linux 4.17-rc4:
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>> commit 75bc37fefc44 ("Linux 4.17-rc4")
>>>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>>>> Date:   Sun May 6 16:57:38 2018 -1000
>>>>
>>>> Reference:
>>>> AMD64 Architecture Programmer's Manual
>>>> https://support.amd.com/TechDocs/24593.pdf
>>>>
>>>
>>> Have you also tested this with SEV?  It would be nice if the kdump
>>> changes you make work with both SME and SEV.
>>>
>> Thank you, Tom.
>> This is a great question, we originally plan to implement SEV in subsequent patches, and
>> we are also working on SEV at present.
>> Furthermore, we have another known issue that the system can't jump into the second kernel
>> when SME is enabled and kaslr is disabled in kdump mode. It seems that is a complex problems,
>> maybe it is related to kaslr and SME, currently, i'm not sure the root cause, but we will
>> also plan to fix it. Can you give me any advice about this issue?
>>
> Based on upstream 4.17-rc5, we have recently found a new issue that the system can't boot to
> use kexec when SME is enabled and kaslr is disabled. Have you ever run into this issue? 
> They have similar reproduction scenarios.
> 
> CC Tom & Baoquan

I haven't encountered this issue.  Can you send the kernel config that you
are using?  And your kernel command line?  I'll try your config and see if
I can reproduce the issue.

Just to be clarify, you perform a power-on boot with SME enabled and KASLR
disabled (e.g. mem_encrypt=on nokaslr), correct, and that won't boot?

Thanks,
Tom

> 
> Thanks.
> Lianbo
> 
>> Thanks.
>> Lianbo
>>> Thanks,
>>> Tom
>>>
>>>> Lianbo Jiang (2):
>>>>   add a function(ioremap_encrypted) for kdump when AMD sme enabled.
>>>>   support kdump when AMD secure memory encryption is active
>>>>
>>>>  arch/x86/include/asm/dmi.h      | 14 +++++++++++++-
>>>>  arch/x86/include/asm/io.h       |  2 ++
>>>>  arch/x86/kernel/acpi/boot.c     |  8 ++++++++
>>>>  arch/x86/kernel/crash_dump_64.c | 27 +++++++++++++++++++++++++++
>>>>  arch/x86/mm/ioremap.c           | 25 +++++++++++++++++--------
>>>>  drivers/acpi/tables.c           | 14 +++++++++++++-
>>>>  drivers/iommu/amd_iommu_init.c  |  9 ++++++++-
>>>>  fs/proc/vmcore.c                | 36 +++++++++++++++++++++++++++++++-----
>>>>  include/linux/crash_dump.h      |  4 ++++
>>>>  kernel/kexec_core.c             | 12 ++++++++++++
>>>>  10 files changed, 135 insertions(+), 16 deletions(-)
>>>>
