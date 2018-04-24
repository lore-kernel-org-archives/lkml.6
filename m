Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2999314-1524572894-2-10709363142843586754
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524572894; b=urhAVYkxIFMvF7QmNWToVk+6EziXuxiJfxxQrjFMdks3jlrrx7
    B/byxGxo2CEF9ItwPYe0xUhgU29zbPr8kJ5OjsZIzrdepvL0Q3yenDL5SXBcYZsm
    8BXkUvjeKetDgcozZRkZVTxy9vX6EW68qfm+kXfaFGBn6jxy2bwaZRuJ3L9K2s2t
    LrFiWoFYo+LG30LTDCa9b7HHKMEV2iyO+9lo33S0R9K0NVQX0gyqx9NpYw/mQ9IX
    irIMQy/c+RA1a7bPHqFiPRfF+lPrnDJwIh1QC5kB2rPhLC1KN/da0I4sGy17H1hp
    05vnzeeaPRiWe7VlQJ6m/ByYLzld3G3G2tpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524572894;
    bh=RlLZyzOQxBd0NCpG7wZKgEiJTDHy5nxBc8MWQuBcbRQ=; b=PXN+gCMHp0ZD
    UGFjAqI0mIZOTJg8a8X7Sc2YibDsmCCdUraCD2Y2u2RL4Au9PyiINKEDDtNz5/D2
    Gw7nc3VCPzXnfnNTnG2uvPVJF0Sv3nW1FPrvRvtSAAhlhAWwe342gUz4bCSbwTgq
    kazkFbWwi+PecUvuICgmP/wt3b4xAW7xdN7ra9TtXQ2JLVaGqJ/Rd7UoznPjSECQ
    mU/JCiOAbHiwDimKKtGLd3Ryy+/PKDr9YDbaczxlvSIBO+XonoasA5aIT8tbwtQ+
    Ep7zRjV5fo0ElViitm4vZWdgJU4UOAk1TcL5o/LiJNp67N4WdvFeRyu0BtpVnot+
    4MmBpqfFqg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b=PSnamDw9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-xilinx-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b=PSnamDw9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-xilinx-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBPibPc7fcSur/A6ZDFISB3E+HLP9XOnUDcqH7YpkHGnNsvfZlqjzYWMqgV7b3cFC0AqITOFEY3TrTD6Y0yfpBxyXqA8K0ZWLn7ooUHTZItnMUOJms6x
    o0gTDntSGZe0hUKlAE3Lqs9WQM1WFFRWOuAxqOlov3+yUQqC0UjA3xP+kdoiaOaGPVKQrTOosHl+Elg6PFRxu5H9LU8MaYLR6ve+WHJv0PQXbDtKJahqkTGM
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=XlFQronSCzDnyy_Vk1wA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756226AbeDXM2L (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 08:28:11 -0400
Received: from mail-cys01nam02on0047.outbound.protection.outlook.com ([104.47.37.47]:41551
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750736AbeDXM2J (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 24 Apr 2018 08:28:09 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; mips.com; dkim=none (message not signed)
 header.d=none;mips.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH] serial: 8250_early: Setup divider when uartclk is passed
To: Matt Redfearn <matt.redfearn@mips.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>
CC: stable <stable@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Douglas Anderson <dianders@chromium.org>,
        <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
References: <93a7871c8654a6273b1ab35a8071e9f830e2a0c8.1524475087.git.michal.simek@xilinx.com>
 <f8c69fee-8889-f0aa-1235-b7a65068238b@mips.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <4e5e4f48-ec79-2c99-a321-83c0e383991a@xilinx.com>
Date: Tue, 24 Apr 2018 14:27:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f8c69fee-8889-f0aa-1235-b7a65068238b@mips.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(346002)(376002)(2980300002)(438002)(189003)(199004)(36386004)(2201001)(476003)(186003)(31696002)(86362001)(229853002)(305945005)(5660300001)(426003)(65806001)(81156014)(106002)(47776003)(336012)(58126008)(54906003)(316002)(65956001)(2906002)(126002)(44832011)(6666003)(478600001)(2616005)(486006)(110136005)(446003)(11346002)(81166006)(64126003)(356003)(8676002)(8936002)(9786002)(230700001)(106466001)(53546011)(77096007)(26005)(31686004)(63266004)(76176011)(23676004)(2486003)(6246003)(36756003)(65826007)(4326008)(50466002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB2037;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT027;1:+OflYe5WRq2Sp1NXmxQXbvPXlG5JskAcmz6ER9jmA1g/g0khHdr2e/eRb6po4TwkBHR7+oBp/J6bYeKwAMVOcUJ5KxwiB+bvikjffu80rsn7EWVkaKBw5RudemVDMJ0j
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR02MB2037;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2037;3:iXThIFcpBmkBX9E+KazksjSL+rDD7x6QLSJaddyK9Ww9taAeMVGuLlv/+cas0fmwbJzmTIQpHF4y2+rqjnskumL2BDRWM059dtOqsneyP/6AR4HLPka3VVQs4ZUDcbeiftEE5GOixU88ByA+zZdQ+uhC16ozKXcmyJqt5QtJU6wtTMVQ26/CUCnogWEwX0sL2Lo1FANCrY/33MONIDuqkZssqG0fESl4hUvJpQ+NJOt+kmRGlZ2PshzkO298UZYOewUEY4TobJb5pl8Yh+/+GjgoLgY0wZjWjSw/RMsk4lJwaKgm9FQzZG/mrGKAGgBViP3wOiCmtuFzQSC+BRDLj4GBCTSYpTvJgkTGxjQ/zk8=;25:WEHazuWiAcBYT/VgF7nhhMKW0FRRI9CkS7xapYuUCkpHhUrgasV1gRjw/Y042rGTTtfZCPKeNsapQbkuyIDo4SQ9zT/fMyAQjgO6JHlWhiSYRYA0zeY9Z3SxkqLkDPCAkpwrnR9PBr0Cg/HP8MbifyqdG4i6KgrnsWp7HsbOGK+W2k9Fuqzr70AEOsyCbSlxBhnMrMk1ETMdIiu0uE0o3PC6ZsTwrzfsTbxVqVf86z4xXKtbKCSS++zjOdGXzZdFePpwwwz4335YL/2tYb+oGWGPzuoXvW9WjNqaZN8MF0FlzZqXxDHzezBUhkhqleJoNKA2WOFjzfTDNZ7MeIVt8g==
X-MS-TrafficTypeDiagnostic: BY2PR02MB2037:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2037;31:G4N+k26h+sdzrD5/gFgfcpTZnbZbnvScPYoCivEa+ps1jcIUAxoonKA7Mx/HvlWa7onD8Yt2LQ+HhLkFfSoIlaZWWNrDsm/0cVoiBjAnu9ebAkJW0zcT5DTicemoOqsMhXW2jpN83E6JWuAvVkSK16yoUzX/45z36b3VkLE7Iy0UFEqZ9nIwdwDJlymUhQuzhUKh/dqnt2REenEgoss7S++v/1Uk1E1PLKEbt6L+uJ8=;20:1dSLnfSy7EFNSBrDONhkNle5GrW+RaxBe4Dr/f1y/XIMbKki3DOvInjS1YAREH/BdH8CXr0t9UXk7EhV1+jaGR+8kcHAKFAZ9sfBw1z+Cr8QyaUPL6IogMaq3XXuJOw8ehhf/JhFMjEWIjJUO25qTLO2ggzTDTmnS4Q99O15DRJpNceWh0U6DA4S76+NnM6C6EbGQ1yekGyHCe3o0m2QwPF9YBQ8BLcgqhXwxt4ujmM2w3Y8W5eez7UxES6INCkRqC/WYnt8KJuCISqQxHVAoF6AwUFyngFFI16LgFfNPmD9C2y/vc3Q1W0wsnFqMb9GrstdmlFPpa1QAjdNzH+QkxUZlaZx7d9a2wyU7S7nMVf3hX8z7mxZPs3em30FY8WF8agiOx6lFqHi9aZEnM/PyybAhIyyHRwbznY+BU9WW+Sq1fokn0RTIht/BgW3CJ5XNurLuAKNa0d4zI/NzoeT9hpSVMsqQFJYWlT7sPJCoxPs8XwQvK5NaTGtBfNI2qH+
X-Microsoft-Antispam-PRVS: <BY2PR02MB20372594CA10AC5C718CE615E2880@BY2PR02MB2037.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BY2PR02MB2037;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB2037;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2037;4:3HxSt3dXSRTYo2tmlfWaoLJyCnIg7bbsHoB4Tqr+WN0whCvt60tmO48zOSm+4RIgDVT3im+UgWeoujdu1Wbm04uMpFgMC6WA2HU3bwAOg2QVCHOlu22gsdzIG/1x+R8s6DPQW/6RrLdE614WOL84M6s4YIUZCRdi7LPQ222T+obNiiK3cxIUOhcL2402TONmyO9BbM03RY21POL9DG0R88DzMPwMuL9ckz4EZkwp6woMcLJBTM+Y4AfYn/Qz6dR5fNtKgAOXvGbTmg7cNYMS3MFe9HK1ZnPQYfk3+hIEdJITRphyPx06P7mKTYnDsTts
X-Forefront-PRVS: 0652EA5565
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAyTUIyMDM3OzIzOjhtNTBPWVIxV3VVbnk5ZkJLMVMzaklDTFpO?=
 =?utf-8?B?MUZKVnBWNk42Z2syWDNjTzdCV2ZnS0JycDcwQThwQVZqN3k1RjJnWTdqcndv?=
 =?utf-8?B?bXN6RVNraGlRQ2xscjdHMExwV2ZQMFlVTmFWUmE4eE9zc1U0d3lZaG0vRjd2?=
 =?utf-8?B?MGJJNk1Gc2pVRmJMekp5aCtQSVpYaWZaelZPWkVrNzJmUEptcytqeWdpZlkz?=
 =?utf-8?B?bUpNSTFGUjRLc2E4R0ZBTkJranVHU2dZUUVvNVVxelhpVFR6SnFuSG1odm1x?=
 =?utf-8?B?Yk0yb2pnc3dGYWM3eU8xbk1GVXZXZXREQUd3ZVhzMm1UWURqMXU5K2Z6ek1V?=
 =?utf-8?B?UTBpVTVNajEzNDJRdjNaTVBwbXE0TkRDdzFXR090dzBBcERld09qMzNtWjlB?=
 =?utf-8?B?Y0VGVEJOSGg2SEs5RXBlRmZwaEphcTZ0ako4amdJd3FiRXZQbG9hZFl2TnNy?=
 =?utf-8?B?MmphNmlCYnR6R2ZHZHFoWkNQV3puQnZCMW55dVN3ME5WZ2lMNjM2a2x1Z0c1?=
 =?utf-8?B?Y01UbmIxc2k4TE1YUmNZcTAyL0NFQU5keU9xMU96M1JYbmhzT2FPOWJpR2ho?=
 =?utf-8?B?SFhCRXNFckJJdXVnTGFjS29tOTNySE1NbHlVcDdVTkJXb0Q3V3pZdDZOUU1p?=
 =?utf-8?B?aTVUc0o2c1cwKy85TFZxNlBLNUVBZUoydVdpcUM1a1puMSthcnltdms4dHhT?=
 =?utf-8?B?bFI2VE5DMVFVcXpMdTJiMmFxR0duMGwxTUpDdWtDUXZQaUJNRWwxT0N1Z2lm?=
 =?utf-8?B?NTlmeEZBZW9FTjA5T2VMRCtKbVBEd0hJOXY2dHFsMVJzMGNKQ2FDWmpYSlNy?=
 =?utf-8?B?VGFwZitsSVRoaUVYQXNuNnJFMTBuZEF3RUVrMllTRlpmNW90TW9jSXVmdWFH?=
 =?utf-8?B?QUZodk4vdWYzT0lzbDkwRGw0N1UxQ2NsVmhTa3FjaDE1amlGTW5pTVVydWNy?=
 =?utf-8?B?Y1dseDc0dUVOYXlsY0kvL1dCcnNNN0NYRW1jeXk4MzFCUEZOQ1hjVy9sZU9M?=
 =?utf-8?B?Y0JaMnZpb05QVXJDUUFKUU9FR2FabklBb3dwZjFVQ2xDT2xmbjkxTllZVTh6?=
 =?utf-8?B?QnYzU0l5ekNSamJuR0pBUEJpZ2MwUlhMZURtMm9DYlRRTHcvVUJ3STh1VXNF?=
 =?utf-8?B?TlVGZ0Z5Tm9VbGxKdzJLN21ZRUNkZU9yK0FJR2JueUxBY01lZ0Jxemh1S0dZ?=
 =?utf-8?B?Umg4cHRRMGduNWVYSkNseFJ1TU0yaHJmZlVWTkMwdFprZTkveGtwc29sNHBF?=
 =?utf-8?B?WHRUS3VXT2xFV0E2cTcyeFdzZGpTMlVaQ21sQ0sybEh6OUZOMjVjRjFIa0J6?=
 =?utf-8?B?SEtJdjk0SG5QSFN3dFgzTlh0MWZsWCtjRnJldnJZcWFObEVJdkhpL1Bhb0I3?=
 =?utf-8?B?c3dkNXVid2NmN2tMcTJWb0JNZHMxUUxLY3lBWUNmRXprOXF2WlpMNjRwVk1O?=
 =?utf-8?B?UklTTmVUaGVOTDJWejF2aStTSFVXM2l4QzBnaUhJWkNjRjlSRzlDdmoyT2ZM?=
 =?utf-8?B?SWo3ckxOaWYxd1I1N3RZMktpbUUrK3hvY05RNDRNUmpSdVJqclZDcGI5bkJF?=
 =?utf-8?B?OE53bEh6U3NpZnZ4WHVmdXJJUVRGeFZ5MVJ6UGdGMzlGM09pazhQSVVjVDJj?=
 =?utf-8?B?bGZCTlNZRGRxU2hPRVJlTFBTUmR2QUNMN2RybjNzY1JuQy9KVWVXVE82b1hB?=
 =?utf-8?B?TitlME8ydGxoVlM2ckl6WHhabXRJbll3ODBzY2FWTjRmVUZuUFdHSGZKQ1l6?=
 =?utf-8?B?YW9nelB6K0xEUHpyZ0taREt0SjBVQ0wvZmxsdG1jOTNDMWxIdFJ6bnRPemlj?=
 =?utf-8?B?Vkh6K3Q4WGp5Rk5ETHpuWHNkRTVQc2RlbmNScHVCZW9pUVE9PQ==?=
X-Microsoft-Antispam-Message-Info: Uh53eurA/NmM7mN8fuyAkVVpjsmiJPpru0xyOkSAdoCOYckEQ4KGfS6j8CZkGHRD1WF+VQmhheALUxVN9v+pO/RUkL01pWbN633AD1+KevhHygTm3TpmMrOF6csbj3oawBv+z4qqG1rA9X+K9p4k3IEv6hCC0Vaivs8Jj0/m84OeID9rN46ERPDv06FrozK2
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2037;6:vb7K5XRN8nFs4GNcNHT2tFAqmgmekEr9DId8YkBx+bpSWreq7aFPXvNX/DhPkqxyvaLPHK/zuf6+FSIYtzXzW7GIzJ+FF7FrXulCd7NS3Crs1J+l05R8CPcjGYPTVHrAL8G2Ne17486q4KeD2sQ2OEdoPDonQ47N1bsCO//X4Yre3NpUu2aK9zrXlwkNvyDkzljjRN7VsdUACJTTbf3z0PwI0PbDunuVHp+SshMQbFISvfzIYv2OU5oeP4smyA+t2bXGP1DQyAtawZ3fPMrWiLAF85Uy/g+6lsDZquQLaXG2bGmopfwZs4g+LxJGCDsGmH3puRyR7EtErr08Hempv51cxcZ6oMzmx8fQphFZZbWvicDnkSkOTu8UisliZ3AVEiCc1wbdL0q8fjlasERB8bm0Ukg3eJLCUJW3M56PRk0zK+WlphIkXdDiZeglkVb9X7eiRHG2VlbS/F1IlkxSow==;5:ROnkyvNv8laje4/w59oNn1eSC5CaZfNvhh1ugcQnJFmqWdWtX5r1S/XrPvMfIVzqdKJrCeBNlRjrJB5j+n4koc7MAYgQM5tW5Tdp1VxeKFj/WB1y5Uy/PP7zpZVNSJMDMBDTvX5i+8Z1G1BKWeQQvKwaUS6rYDdKuQ/hAFnozaE=;24:s5SiI40+P6L127vnH9vHcl9LiQdgD9BwAunOwMD0rfy4hklWb6+pqKFapFGbnZCz7VJd9LXz6Rg6Lzt9FbvOpbxmi3VoCgA2awh1zV3bppY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2037;7:6tqV93W1ThcDxiOE94RlDDVvyt9c4Hf3m/aNex41HIdC/urBJ3SF0E6n/2Wesab+ynsGWellxzawQL1KQ3S9CaeSuLMTIrOpBmV+Yo2x83+cw+4OtyASgE0jmyZXxuBTrI82EwfbhMttyrfbrviSU8np4FjtxPhJA09n3lCE1T8br/JoRKL6TJdzZ+PGUp2ACPsETxsy/sb+D5MwhGAFyHQ1MVG8nF2PnTy5EBMkGpmQOJ/ZDqU7ew9YT9bQH9+7
X-MS-Office365-Filtering-Correlation-Id: 4ad579df-30d5-4490-f26e-08d5a9ded4d2
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:28:05.5283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad579df-30d5-4490-f26e-08d5a9ded4d2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB2037
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Matt,

On 23.4.2018 15:21, Matt Redfearn wrote:
> Hi Michal
> 
> On 23/04/18 10:18, Michal Simek wrote:
>> device->baud is always non zero value because it is checked already in
>> early_serial8250_setup() before init_port is called.
> 
> True, currently init_port is only called from the one location and so
> the test is a little redundant, though I don't see the harm in testing
> both inputs to the divisor calculation immediately before use such that
> any future call path avoids setting a bad divisor.

I will let others to decide.

> 
>>
>> Fixes: 0ff3ab701963 ("serial: 8250_early: Only set divisor if valid
>> clk & baud")
>> Cc: stable <stable@vger.kernel.org>
> 
> Even if the test is dropped going forward, I wouldn't consider it's
> presence a "bug" such that a fix needs to be backported.

Not a problem with not adding this to stable.

Thanks,
Michal
