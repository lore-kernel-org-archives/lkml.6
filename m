Return-Path: <outreachy-kernel+bncBDX4F3XH2MMRBBMLX3KQKGQEUKJFL3I@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1521452422; cv=pass;
        d=google.com; s=arc-20160816;
        b=OlwY2Y7lljU4a5v27kaBbi8HAmFyLC4AkcGBoEmUdBx9UHGfm0EFtwIWPpma6owxnw
         4OQaLF2I3zC5S3kJjRd3Nl3JrOVVbpxamh3oMqpL1/d12JFdETAz08v0CgWvLbqNzHTh
         hJD12zC/Nx/+9egm0Ck2O/uvk/nhJEjIitORmpPO1F7Lb2+64nCp1lGhNVccGTj0yJOd
         ql8pCNY2M7nduLETD735XThzS1oMT1jsfZnRNlccmR3vDOLiXYn18q3Rfva5EW2rOkKZ
         EdfHaKTjJYFxn4q3M1FlwKNPdASoQTztsL1+q7p0m1bNfQW6HAwSRX9KdLgQu5YYXIlM
         CIFg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:spamdiagnosticmetadata:spamdiagnosticoutput
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=Q4ES/L+m+v1Ur+LD7WZdFN8QLWSg0dLgdbkDZ9dxMQA=;
        b=P3KaKJai9tWew90k7mJgbiK6XMQbIy/xlg3O6e6K+YYDT24oHzSI8SPNDH8px3KHKY
         3ldp6225vId5kNy4ldxmabQNYI4BzeIxvuAih/wErh/JL8QfdY3s8azcU3PLTideb892
         I+/3ftNjmE5feF9ExKFV8esISEQOfj93PX2jWiI9qZ697TvqCgH1/EdltRxFnSYj+vER
         9dbV8MLdNG1UFlf17KZuXkfm2bdjk+ch0ClazSuHq/8jE1sZ6MZyfH5hwVd/FwyINZWs
         j1XdMnsZ/uKL97kFzWAJkP56viFWQiPOQfNRWGkdwajInH0S4+o9ndv5I1JS7h3N1a7l
         4o/A==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=Fzy1JJNE;
       arc=pass (i=2 dkim=pass dkdomain=amdcloud.onmicrosoft.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbdx4f3xh2mmrbbmlx3kqkgqeukjfl3i@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDX4F3XH2MMRBBMLX3KQKGQEUKJFL3I@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=Fzy1JJNE;
       arc=pass (i=2 dkim=pass dkdomain=amdcloud.onmicrosoft.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbdx4f3xh2mmrbbmlx3kqkgqeukjfl3i@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDX4F3XH2MMRBBMLX3KQKGQEUKJFL3I@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1521452421; cv=pass;
        d=google.com; s=arc-20160816;
        b=XCe4faeRiOGCQO425I64VqrwXQ3EKoLMlvZHrOkQ0US9j9SnvBfxNpBflwz5Q9wGfK
         KuyNagjMOFa77lqd0mcH1XKDxN3EIcI2Ujigu5nYpFbPM3lJSUCSqfLh0Mna0V0QCoY6
         dvGBbpAeXoniBdnel+UvN4C+7eWDZen784hCBwa+hHxxg86+K+Vz1rQ9z5UcmeYd5fIw
         5KClcHWZyFb/tXu9IQ8Rx3GKml4xdgpBR6ijCwPReY7PVfic/UEUr6w0y69NtanormqC
         Bi0W6CN2BV6tFdE2kMjSBlQB2ILRfJS8WYaKuqSYCAEbuxeNOSVhLpC8xa3sZ6Tey8gZ
         L8Gg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:spamdiagnosticmetadata:spamdiagnosticoutput
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results;
        bh=Q4ES/L+m+v1Ur+LD7WZdFN8QLWSg0dLgdbkDZ9dxMQA=;
        b=TMw9Q/6IsMw49eoP5CI6U88V+ARC+E+CTb8L3YGrncG3YKgoab5YiF4rKYPNsib8P2
         uGkvVQ0z4mjcGprY3TzJciZQh6sOjXK789zbBFVGb4m/oSJIX6aEOp2b+LGvQ7Z6r3/n
         fffBH7ykG8G2TTT9mNGMUR3e5UhUVimdMSB+lj+YbnKXJTfKHkYk+ASSBwPzTkJwJAgo
         60TWAE/6qwlbs67P5VAGRPMZdLNkFqDUd7nOzo62JcNuomv2RsQtEpXPsFoUQZ4Dij9l
         YCkBS1tsX4jnzlhk3LNGeUDxu9lnGNCQgN4A1oBx0UGAT5wL4d+2oYOMkikbmVcM6mvU
         cZew==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=raqHmxn5;
       spf=neutral (google.com: 104.47.34.41 is neither permitted nor denied by best guess record for domain of christian.koenig@amd.com) smtp.mailfrom=Christian.Koenig@amd.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELsc3k5PhdCR6csOoe3FkAL1hiQHikJcGYJ/tvhiLBjumzVZACxGM4EGSzmHy3UAN3luXjiLQA==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1521452421; cv=none;
        d=google.com; s=arc-20160816;
        b=Lk8rIGjuDPDxrlOjM6qCG9XeWKGEBETYJ2B/k+uHi8HxR7SnPcW8/h2SXxai7dmHVl
         eAJn8OZk+xSEjY84P92pL47g+PyJM+KigmFFj+/OFWRtDWeieIPBh3PBl1fCbKKbR3h2
         4V2b0EJJ3ba2HYJwiAuSnAwvelLqTMMsDmdx2nO6fxMyYMfThTHf0IzAsTd7xR6mlola
         8bJgWjVf1DCD/RlFC4mrwHgQFnX1Gnxwd6/kB6/dFccvOWYdOMIT9u6JxeBfCBkdHenU
         OffJFIjL/j+5jdfNSLYwCLctv6Nm+INYuyamiMl1OkR3EfGjPivZ+INiHdKDEHux4fX7
         x16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=6fMvPTnLxQkMghskKZWQoLeyr84QC118oSqmJwHK5sE=;
        b=mC+CXFYNYFpY6Ks4bhezacXAm5HXmc86NV9CHjV9QMl7y2rwTGdpdldciY2XVKQGpF
         LEdY3KRn65AJrDDW9HlR2LDv84Wg0o7jqsIomYiAuhiXCDssU9t7CR8xaaPCQ1Hp2IpV
         kUX9uSQ+aSjaD6I6a6cz0WbbzX4Ea4z5j4RZN+48sJH0+Vlww6OCL4zEsG06lRDlPLeh
         0SHKPRWK2axjCxnmCl2vBbKFke43eWwlWfV7aD7Ul12oxduxT+RWiIEAODBTR5YYRUpK
         Rte4hskygXU7TMbgvyToTCR7zhIUamO8ZC37CYgSThMVvLExdQICSlZTUpJ4uclDOHws
         ozmQ==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=raqHmxn5;
       spf=neutral (google.com: 104.47.34.41 is neither permitted nor denied by best guess record for domain of christian.koenig@amd.com) smtp.mailfrom=Christian.Koenig@amd.com
Subject: [Outreachy kernel] Re: [PATCH] gpu: drm: Use list_first_entry instead
 of list_entry
To: Arushi Singhal <arushisinghal19971997@gmail.com>,
 alexander.deucher@amd.com
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, outreachy-kernel@googlegroups.com,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180318215105.GA15431@seema-Inspiron-15-3567>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8b1e22f8-7a05-b66b-8825-7d4d97e46dac@amd.com>
Date: Mon, 19 Mar 2018 10:40:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318215105.GA15431@seema-Inspiron-15-3567>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: HE1PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::13) To MWHPR12MB1728.namprd12.prod.outlook.com
 (2603:10b6:300:112::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: caf25ed3-de66-45c9-bd11-08d58d7d6d9b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1728;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1728;3:SQNag2qbBFQ8bZtf8Hq/aCCdX0g/creYzTgYLKwbcR8ly7znjf6LiduqbSJ6sHRhfsaGfxr3Kn3yqnaYCQ2fL3UmGzVcuMwMaDTgS6UYudxD6VJ+5y05tVlDwuYveM7798qvt3XvjG7ZJUPhT/izHOHBs3PBZdY3LdN9T1mTmhFeXKUUV3ruUkP0CBBBm6fHAiNCwLeyPWtJxFk/vLq7i2vKgpT7ZnXYHn80DWQfaKr8jyXB+G7Ffs7nYYNhsUTG;25:Ar6cG9LaUSzjIqVyKe6Mrl3pwGtDHfyxNwy/EUfgPF1zAAoXnZRNZIa3SdE8PYP2FdRLEnbf2BpAClWM3EAmDYEBJdjNuRUV89DX9puv2hxa7ZFzz25mT0oXEPveintGwsiagPzPiFPBokzj4tkjkPqbmXtU3o34LbjmfTzxSBFmDCVHm9bQ80IjWWmHzFOVb1WMxG98zIpv/4HJ982FtZs6zhAcrc/qWMmMc4tvOSeED8o5b/ZR3hfuddt2BylrDeJvljPzsp2H0DLtQ5oOSbFdL6SFZU/iZVaX6iXHQpOQCoFWsxqxKDW/so+9lOQ73byxtmVO2+KIM7QsIR3C5Q==;31:YJ3jof+sKucC0pLie8rpBGVG7wTgRRFf5DRl/c0ilx5NYutnXaxaELEA659oj1826pEtCMRjwk+WeFfp+/szaA95v3+UUTta5c0AjjiU0KPRVX6NN0TQaYljbvlJoiTG8Hl5ptuZdyJGr3tTfjPVcRcNtfgtbXgZTS3FzE2Ctt0yzGoGrs6KlF7zRGkB/HHNyhh4BXkJpaSzgEj5V5UWU0u/6OcS+xiGmeT2FF8ws9o=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1728:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1728;20:grKAKPyYQE+VzrkY+vxauyKHnNTwfVLpEV3qOTYj6eil7xEH6+xXxqygeTdqGFk9FYNuYQhTKpGyaE53ft3voHVHzBPS4RrwakSKWd+zcEYijwPE6eSW3jNpMK/rxDPiU+gFXzZOMB0QYs2cn6xBJ83BqH0Z2J5JLLsLjGN+QPSQZjccHWq3n7BwjZSclW+pRUfLZV86bxnqC4AwMZ5m3c6wXKNeHLgGQB1jlVI5wchne/MBTAejO0IJ/2cDM8fNbwWGBo9PTbQIEIhT959dYCksCrM+z81vttkez+UFauRc37H8bR/YfmIvL3vtvJN5oz2PYnLeHsYfn8Cb5cE6ukz7fzb4gJb2vXpBpEIq3NJEg3SeQHSfSpiXzHH9p8W8xJ48kGhMJH96oIzx9mMXw38Zu39BD+6HiClm6+akhjZ8sBNDbdZk4uPy4t/dxFRIBSB+WJakI42qi1xbQazHKFIRMt90cAy7d97/v5g0B+gdFpfiGIZHct5IYOXg07rC;4:FS2fGwI9G8EVXq34q79fnAYBxKjJ7thiBxTnCbghnygWM22gZLEiVfDXE00MI60Qqc7LGQ7zzWEME6guew8ycEbS90pxdvLJnIvWpaX3y3rD+3ay/Cgmtu1axoezRWZVVvW8PWf8km0PSgLIXzkjxxZs2pzC2b5l07qrMUQIERbk3c1P7H/3YcjdHgNgwqeEoKQ0QQGymjKrTxHEpuUdWgZeXgOF7ZIjSzUfz2joC9mW1/cLFDmEKSEIw1s4WSg5gVLANenFofYBeyFb9aYsfmpNed7iO4Oe85+bxJi7GTZHNxX1rnryVMJv0BQnLTWg
X-Microsoft-Antispam-PRVS: <MWHPR12MB1728C525506A78DA8DCAD7BA83D40@MWHPR12MB1728.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1728;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1728;
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(189003)(199004)(6246003)(53936002)(316002)(58126008)(54906003)(65826007)(8676002)(81156014)(81166006)(31686004)(8936002)(5660300001)(50466002)(76176011)(105586002)(67846002)(2486003)(106356001)(52146003)(52396003)(52116002)(23676004)(230700001)(64126003)(72206003)(46003)(478600001)(7736002)(6486002)(305945005)(6116002)(36756003)(1706002)(2906002)(68736007)(2950100002)(229853002)(47776003)(16526019)(86362001)(39060400002)(386003)(6636002)(25786009)(6666003)(31696002)(97736004)(4326008)(65806001)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1728;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzI4OzIzOkRSZXBkTkYxMGlXU2FVeXZpYUNoTE8rajhO?=
 =?utf-8?B?eURpV2xvZ0dVMU9oVUl0eDdFT2NYbEp0RVVPOWtzTWJwR1NwdWpPVWlvNGRK?=
 =?utf-8?B?ck9rSVVpY2VESUhhQ3kyL0ZsZFlDZ29TV1pJTXdydDZXMWh4UnJNcDlWR0RC?=
 =?utf-8?B?akh2L0xPeTQvQkVnRk1vSnBrRjZ3TTlZM2N6U2ROMFdlSVllbXRVanZoVDJM?=
 =?utf-8?B?ZEZ3RFVtY1UzQm1ORkpEOWlWTXlRY1VNSzIyTVRZRGZOTi9mYWNPZExIV2N3?=
 =?utf-8?B?YUlhdzBhaDNPK1lVVEZ4UC9vUXlvellsM0NIQ2w4SEFVTmR5YkMvaC8vVDB5?=
 =?utf-8?B?YTNUUmN6dmdOenNLaTF1YlBzdGRVQXAvM01tWVMrcDNTTXpHL0pTUHFtNnZw?=
 =?utf-8?B?UXY4Y3RWN0sxT0xYdWNxK0NVRklMSHR3dTBUMzB4Z1hWRE53Z1AxbHYwMjRx?=
 =?utf-8?B?ek5wbmZ4OXl2TUZ4TURHWHhQcHRTR0E2VVFWUEdWNko2M3BUNlo5bFM2cDFW?=
 =?utf-8?B?eHJwMjVGME8xK1hCb0Jld2xvOEpqRW5vTmxKZTlYbTlCa1RTN0lGblcwOThi?=
 =?utf-8?B?MjIyV21mN2ZTc3RxZXh5L1RkcW5INjZjMW5MSlVTM3N2WGdvSEVmd2Rac1hZ?=
 =?utf-8?B?dG90VWdCUnlXQXlvY3NlYndEMkkzTFRLcDBtNTdKR3JxbFJoUUpIN1dTSmcx?=
 =?utf-8?B?K3ZzZjNTR1AzRSsvU2FWbEVEQkpVODd4czZrZEFnUUVuZTRvdGdhK1I3dGxh?=
 =?utf-8?B?ZE9VbmV6bzBEcTl0TmFUeWpsZ3UveUMyMk0vQ2xxWDRmcyt3ZFltRTJoM3BE?=
 =?utf-8?B?anh6WXFmQlJDbFdXRUFFNEx0d1hvcExyc3VUZVZFenRENkVuQk1ZcTB0cmMv?=
 =?utf-8?B?NzM1UktDeVpnRGlZS3lsaWFsZnJyay82VnZaVHN4eTZlSXNmQlgrWUFkTUVV?=
 =?utf-8?B?TmxwTjF4eFdhaEhQM2kwSGtlZkpxa0dsOUlqN3ZscVYxYTcvRkFxNHpDYytV?=
 =?utf-8?B?aTBVNjBseVBCQ1A0b2ZuZzBzU0srVUxSOW1QRnA4NTA2a1RrL3JaYXBpbU9J?=
 =?utf-8?B?NGVMREl6K1NmVi8yZzZZdkVYUFNEcjlJWlRWdmtGdWphaFVjVGsrYlJxYkx4?=
 =?utf-8?B?b04zRElrY1VXdEl2T0p4NU1UTUZMcDVyODl6Nk41RG9jT2d5a3VIT3hKZ1o4?=
 =?utf-8?B?R0RTMytvSHhIaXpNK1BVd3ZPb083SlZaeEtqaWJMN3VIazQwSGpMMmoyRjhW?=
 =?utf-8?B?UnJXdmFxK3llck45dGVubVVwQkxPWFlialRDc2hXMjMrajN5a1I3UjNjNXJU?=
 =?utf-8?B?ZGViSDdOR0FWeXl1cDhnZGpOdXVTNU5KMkNPTk95R1NPS0R3MTFqb1RtY0ky?=
 =?utf-8?B?NENNdEpVU28rYW94aEZUMURPdEFCY3hVc2RScWJpS1NqdnhVeUpCbngxU3cz?=
 =?utf-8?B?dFg3OTRCRlNWYUFMbzdRVGNRdWVqa0VvckxmOHVlSUVNRTFWTTQzSW5MWFhT?=
 =?utf-8?B?Y2ZjZEp2RjNmMXF2T2F3MWQrYlRUSS9wWHBtS2VOK1FPWkpEUnFDUzBLSkkr?=
 =?utf-8?B?N2orZjNtUE4vUGcrV2NHWXorNXVhMDRvM0sreVAzbEN3OStXUExwek5ZVTJo?=
 =?utf-8?B?bDc1Q2VUOFZ4Y1d1WkZHZ3JGelYwaCs3L1JOaVlmSG56NTkxdVF6eUsrUlpM?=
 =?utf-8?B?Wmd5aXNaSmVvWkUzMG42WnVwQzMzQ1g5SzFERjZBa2wyL093QzZGVDFYM3Yy?=
 =?utf-8?B?OXlyTHlUNFZTT0J2dHNkeG8wakM2L0lZMjJoS3d0Y085d1IxMUx4TUlFUVRP?=
 =?utf-8?Q?ozKG/85bD2qwk?=
X-Microsoft-Antispam-Message-Info: /dkTHocWbn6D54rneC212kEvQKvybVbpjisEdNVLdGyDU3/wQaPw7eVhzIGsohuJAp2r2CQc88zVkMLGeIFVX5YxjMOcn+VImkjQBajZ6NAs+uQqhxmZ/4f56qKG3MWTNXXkrjWePD7T/GrnevHRxuC0sr6VbMCq8EY5+lIcocmuf7gh0MiO7Ayxr3z0VE2B
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1728;6:wkSpTg/cpdMTHTJiQd+5H0X289MCQepmlUy+XIFgriz5Bb2iHOOL6/3L/e9A9bgsCyuCN7aCZNXuPKWgq42FIRbdH/yIb67ig4uOjV3n4nwmdjqIUh4YPAYf4YOZEGF0hSi0jvENSj264ai4wos6PKE2uD744l3CSjKl2ITTj8rOdQuHZ0ehHRbnIlMhoqOMDjUs6CTJkhkTDL+wHv5BFMRztier33ozhg5cQK3YV8ewB3JS4Fb37acWLW7i8tp4hxtJ4kB+Z8bqo0i6F1sVmNV4moApI7CLRRG0WayL/OFKtnOrXA/q7F2zEm+4jumT+TcxR6WY/lqvlkKIC/UK2cwmr1TU/R6/ubDQVEuFcoA=;5:+saFOSnha3PudCUTsEnFdK+E26wlj79hIpRO0FKtGoO9lyeEFVRC3fY8Pp5RcshIRNCPRDB1pDn0HaGl9RSRmXPXSz/pcMpJEGYNLFX6k6AgAcj62mp6gOgmkI6A6+83UMP1+aRw1pGoh7MNFLexAhP3LPd7eK8OA30aTcwhuug=;24:jGWtuL1pz/gQcZAplfrfamCrqQHd5IrtyT+q/5SSQ9bQb6vUDFi6Ny2yF735SizwTumZSbu9gCk0Q+NF3wPSof+MnRqhefTgndo2y3EQQ3g=;7:gVvADkx4D8ESvzfYnmFksv9njeWsU/wegPmZnEUTjJpQFoPnMlkyRln5t2GT34mfn3ak1geBuSfHzd4LeCr7i8mBRTFJTJDwr36XZrUJCTad6BvkU2dmCeJFWLI+On64NXPafUjjmeMAVFlVSIi+exNsmKSHkCBj3kvz5aHMi/S4dHvFUA4NokhJ/JA4Gqc1O5+i0Zm0MJAWfqOCP0lk7UHqDPYFyYOHZNWkA+GNiEgb0Sdd6UrGcst0VQkxLjAG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1728;20:CcluQerF0EDom44NezwmkOLHDYMKt98kgh3IJ1hYKuvdIbZumTx1Q95HDqtWqDf0xGUUwQ1qhka+DmHyVoF7fB6PIqImeWqlT01egsb+w5Sky1nS+zJt7nUqp9UoL9yxH1PTxpHeRk8lyykIirWSRDn3OZcW0DIkirC2ylcdxi0uqZwKXmn3WeR7k+g5hKJsiJ/v6ieLA71FQ6M7VhLnylgx2YliXGc+bNqo66N2SMQ7d9T1DsqV+6sS9e5qLsae
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 09:40:16.6831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf25ed3-de66-45c9-bd11-08d58d7d6d9b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1728
X-Original-Sender: christian.koenig@amd.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com
 header.b=raqHmxn5;       spf=neutral (google.com: 104.47.34.41 is neither
 permitted nor denied by best guess record for domain of christian.koenig@amd.com)
 smtp.mailfrom=Christian.Koenig@amd.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595313921234886794?=
X-GMAIL-MSGID: =?utf-8?q?1595358494868833708?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Mhm, actually that patch isn't correct. What we grab get here is the 
next entry, not the first one.

We don't have an alias list_next_entry for list_first_entry?

Regards,
Christian.

Am 18.03.2018 um 22:51 schrieb Arushi Singhal:
> This patch replaces list_entry with list_first_entry as it makes the
> code more clear.
> Done using coccinelle:
>
> @@
> expression e;
> @@
> (
> - list_entry(e->next,
> + list_first_entry(e,
>    ...)
> |
> - list_entry(e->prev,
> + list_last_entry(e,
>    ...)
> )
>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c | 4 ++--
>   drivers/gpu/drm/omapdrm/dss/display.c  | 4 ++--
>   drivers/gpu/drm/radeon/radeon_sa.c     | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> index 3144400..646f593 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> @@ -158,7 +158,7 @@ static void amdgpu_sa_bo_try_free(struct amdgpu_sa_manager *sa_manager)
>   	if (sa_manager->hole->next == &sa_manager->olist)
>   		return;
>   
> -	sa_bo = list_entry(sa_manager->hole->next, struct amdgpu_sa_bo, olist);
> +	sa_bo = list_first_entry(sa_manager->hole, struct amdgpu_sa_bo, olist);
>   	list_for_each_entry_safe_from(sa_bo, tmp, &sa_manager->olist, olist) {
>   		if (sa_bo->fence == NULL ||
>   		    !dma_fence_is_signaled(sa_bo->fence)) {
> @@ -183,7 +183,7 @@ static inline unsigned amdgpu_sa_bo_hole_eoffset(struct amdgpu_sa_manager *sa_ma
>   	struct list_head *hole = sa_manager->hole;
>   
>   	if (hole->next != &sa_manager->olist) {
> -		return list_entry(hole->next, struct amdgpu_sa_bo, olist)->soffset;
> +		return list_first_entry(hole, struct amdgpu_sa_bo, olist)->soffset;
>   	}
>   	return sa_manager->size;
>   }
> diff --git a/drivers/gpu/drm/omapdrm/dss/display.c b/drivers/gpu/drm/omapdrm/dss/display.c
> index 0c9480b..fb9ecae 100644
> --- a/drivers/gpu/drm/omapdrm/dss/display.c
> +++ b/drivers/gpu/drm/omapdrm/dss/display.c
> @@ -158,8 +158,8 @@ struct omap_dss_device *omap_dss_get_next_device(struct omap_dss_device *from)
>   				goto out;
>   			}
>   
> -			dssdev = list_entry(l->next, struct omap_dss_device,
> -					panel_list);
> +			dssdev = list_first_entry(l, struct omap_dss_device,
> +						  panel_list);
>   			omap_dss_get_device(dssdev);
>   			goto out;
>   		}
> diff --git a/drivers/gpu/drm/radeon/radeon_sa.c b/drivers/gpu/drm/radeon/radeon_sa.c
> index 197b157..66c0482 100644
> --- a/drivers/gpu/drm/radeon/radeon_sa.c
> +++ b/drivers/gpu/drm/radeon/radeon_sa.c
> @@ -158,7 +158,7 @@ static void radeon_sa_bo_try_free(struct radeon_sa_manager *sa_manager)
>   	if (sa_manager->hole->next == &sa_manager->olist)
>   		return;
>   
> -	sa_bo = list_entry(sa_manager->hole->next, struct radeon_sa_bo, olist);
> +	sa_bo = list_first_entry(sa_manager->hole, struct radeon_sa_bo, olist);
>   	list_for_each_entry_safe_from(sa_bo, tmp, &sa_manager->olist, olist) {
>   		if (sa_bo->fence == NULL || !radeon_fence_signaled(sa_bo->fence)) {
>   			return;
> @@ -182,7 +182,7 @@ static inline unsigned radeon_sa_bo_hole_eoffset(struct radeon_sa_manager *sa_ma
>   	struct list_head *hole = sa_manager->hole;
>   
>   	if (hole->next != &sa_manager->olist) {
> -		return list_entry(hole->next, struct radeon_sa_bo, olist)->soffset;
> +		return list_first_entry(hole, struct radeon_sa_bo, olist)->soffset;
>   	}
>   	return sa_manager->size;
>   }

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/8b1e22f8-7a05-b66b-8825-7d4d97e46dac%40amd.com.
For more options, visit https://groups.google.com/d/optout.
