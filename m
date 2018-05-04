Return-Path: <Akshu.Agrawal@amd.com>
X-Google-Smtp-Source: AB8JxZq8+1w52YolD2t47o4DG8p7l2DQe4eavrrCG2ZgVAY2IpxaXqKnCxd/lw2oTIyjNpJLuTa2
ARC-Seal: i=1; a=rsa-sha256; t=1525408503; cv=none;
        d=google.com; s=arc-20160816;
        b=MlMvMMhzlmmqQIQ84WgnQeaQQUYS1lJ5SnmFe8LFLDUbIbpgk0TpJRdpr4ped/UfQj
         tMAAM4tY9Y9EsXpkMIafmFhW6eR5fDPEZok6ejoKVU6aQ/PeJP2eKRq5PaodYtmajOPY
         HM9L6n494NhTl8VjsqHcFxb614cgNSjmpiyYdHuiaKtSVDV/OdfP9aJIq6xbOAIGYlUR
         NzwpgH3ISsagk7QjGOAQMgUjK31QZ0Ajk+jvY9K7tlpEMvddsHLaea72n5mhZ25snwm8
         a/oRoaba9lAD3t5O0deJ7YurMr49hBO4LZwZKt3RAS8g7o4WjA9QXrVSWnVKlf8JWXEt
         WdXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=c8KjABzlSGYoW0zHio1p/0CLHDV2wnjpHm4qP8cAMHU=;
        b=iISZDq7C/wYL2z/Mlect8K2OBQPbzhDxujn5oGTPkFUvHMZQUhE2mjgC6riS39aLbM
         0g/omldXpHNocRwHn+vDHLCVE8lEevVpuo6qyXOMCBepP4+ozys/51kBE1V3JxcohDcq
         djLNBMYLzVg1MHiGtP4SY892iYjcRMda4ventWV17/Fa31AC2Oy+1fv07V/XuMBRFQc6
         irVFlUSTG5RQ+5LHfuBvTKYLlD/WYcN1iJVIs59p3ufH/G3OzV58s8sJ0izMbbuWe4Zm
         CxApNZrkBvR5jtG54azMg1iR5C+UpggO4xdk7V3I8aE08TPJi7nDaPYiqXmiYVsAT8EZ
         cycg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=DAwMdT19;
       spf=neutral (google.com: 104.47.37.61 is neither permitted nor denied by best guess record for domain of akshu.agrawal@amd.com) smtp.mailfrom=Akshu.Agrawal@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=DAwMdT19;
       spf=neutral (google.com: 104.47.37.61 is neither permitted nor denied by best guess record for domain of akshu.agrawal@amd.com) smtp.mailfrom=Akshu.Agrawal@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
Subject: Re: [PATCH V3 10/10] ASoC: amd: dma driver changes for bt i2s
 instance
To: Daniel Kurtz <djkurtz@chromium.org>, vijendar.mukunda@amd.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 perex@perex.cz, tiwai@suse.com,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 alexander.deucher@amd.com, weiyongjun1@huawei.com, jclinton@chromium.org,
 Guenter Roeck <linux@roeck-us.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1525207810-1305-10-git-send-email-Vijendar.Mukunda@amd.com>
 <CAGS+omC=fZsFvSaxqFWEo0Pkj1Rcqhixy_oN7PWry9F0L_9c-Q@mail.gmail.com>
 <06a8f6f4-3bc0-656e-9c55-84f88727d6fb@amd.com>
 <CAGS+omDKpPwyUMYwm-ai5cr+m=JLh+yjYq_oDfyRBppqc8DPDg@mail.gmail.com>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <78cec135-3ae1-4d4b-4b19-b7fe1577294d@amd.com>
Date: Fri, 4 May 2018 10:04:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGS+omDKpPwyUMYwm-ai5cr+m=JLh+yjYq_oDfyRBppqc8DPDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::17) To SN1PR12MB2365.namprd12.prod.outlook.com
 (2603:10b6:802:25::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2365;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2365;3:51L1v0AgqNIT7AQaYU+DTWjVJi9cPiG81iFn8aTsDCckAaVSU/cLEx+4JcKsdmWAI7Vi0CJ/BEHQvjd1B1OI8aS/hba2PLi8ZooEVjTOx5xFXe6q1H4rPsFRaVZ9s7bhqIRQqeDSmlTHeq4XHQ3xJ7nDAvDTI7lPLvbHa3uLzE8BVD6Auv4ipUiKXZmJ30+D0ZjDQ34b7Z1GnhOkrbCMUp/lyuVV1Rgb+eVOEwfDPMvMnoWvL6j1XWXl9MjnHFy7;25:/1h0G5ClJ9ijLbBFHc1Y4KTCv5rBdsGAPCOtXdX3hKfPVb7qbeeS9AfZQQeMYFWlYTnpMicwLYs7vsmYMV9wRBHhLWtFDU7D1PGYxatAcuWgG5+qvf52aaTuFSE+YVab1TqSvtHovWWm96q1idVgFk5sIE6FEZP+F0vDzS0BRyfegcjChxuY0rXU1KUyowg5S1aIfUgibhl8gAzkj5LOfmEE6MXb13mq7V7m02JgcCEjDTg5y8aoaZJD76vla4E764JCpq/n6EyUgyJ3E2wJAQZ7pPPtqC+PuoXcpNXOFaB4INWP9EaRaTXPgUbRoaMKC8vVqVvloYj/cr1bhjpfOg==;31:bP5psbFjHm8ZFdK6PZMF1nVahCOgdiV7qkp2D+tk8FfxyxYrMCQgUajgJfSMzRby/hoXibpLhrN7kvsIBegIDPiQKtSb7L/mTyVKoCp1bYbgTxgIamlbm6eF/oNeDvMeoIdfsYZnNURWDe+D1jLiNxP+iM/l3Wfqs6Hnbn4xYyEbZEIbWIgF9Tksoac7F4qC9e0ScojXuHFxrIdLLSnyQBjijuVp/1C221Ci1xCO97I=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2365:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2365;20:bhWeubGEiYP1G77NisYdCYaNaN2IB86b/6o+zA8SRe6q3J8vTpg3qxL86LTg+9BUn73vKmiN9N4tTiIysCcsZCh3E06XHrJYnuaBqYH8+lUYMUnMlmldDGhox24VxCzXCsrmTUlwOMXcEsEyGkku/lMC8YoG6m7D5bDBrhE0zsLPtbSI4R94yEAzDuwSbizzA5p2UkQ9etNq5TqLIWW4cTqn0A0qsxucIS4YZQHlLkbnGVJwf+wLdMujDDrHYaeScgePmrT6riqCwT599PVTuN9zuHOJldZhoJ6oBsNfIj1/KEb60pkpgkkAZATtp5Cwg0s77W8Ygrxeyu8ugOcBRY5JXUsx5w9gpm8Er9joeKwEXq6LgWQk+yU8BmvZeAo1CAKpqwjunsn0KBHRlW5Q2RfFO1iJxg/Aq7CWGmkQNk5PVwk1QBRpsbAdOLSXCmyUXk1pfLupcKgmguNFe7cB4YcCFHDpAQWdIdDlAy5NRjqjP/SOuxqjeu7LzFSIJoKi;4:EC1X/qe/IfpqVA6xiGt3dURrvxlweJgkveDPurPYTA2dPCch2h9R7VSl2Zq0GU78ct6BeJGtEHhWR2FO5qAYloQwMkrpjndRKtJ7/64dw3RgLO/s/HbjCBjizbSl02p/P/9UB1kf8cEXr9ETJgzmgeuawhUNimsjUHP8Gny9ACbg6anL1jqN0eipuVH//iJaY5XThEg+Pq+FMw+N3ajVCBl1PDa4zziBMZpC+eUCPCAuetIXNVPvq0c1gcQj4zyk1Ssf5TcXJX23t4+YmpV5adqRqNsJEO3x/8pBKottdZy4xPor0gTBvH9uPDatKggH
X-Microsoft-Antispam-PRVS: <SN1PR12MB236563B0C0D02C10B390B0A4F8860@SN1PR12MB2365.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN1PR12MB2365;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2365;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39860400002)(376002)(366004)(346002)(39380400002)(189003)(199004)(68736007)(53936002)(26005)(229853002)(54906003)(105586002)(39060400002)(230700001)(305945005)(7416002)(25786009)(31686004)(3260700006)(97736004)(93886005)(7736002)(316002)(106356001)(65826007)(58126008)(31696002)(4326008)(6636002)(6666003)(16576012)(53546011)(47776003)(86362001)(72206003)(966005)(5660300001)(3846002)(6306002)(2906002)(76176011)(50466002)(36756003)(478600001)(8676002)(52146003)(23676004)(2486003)(81166006)(486006)(81156014)(6246003)(11346002)(59450400001)(6116002)(386003)(2616005)(65956001)(52116002)(446003)(956004)(67846002)(65806001)(64126003)(16526019)(77096007)(6486002)(8936002)(186003)(66066001)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2365;H:[10.136.128.133];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIyMzY1OzIzOjgxMU9MZTBPdHBGNnVWdm5JSG5pM0pkYkV0?=
 =?utf-8?B?Unc4MHRWM0tLVktUTUphcDdIYmt1Y2dTbFlVcFQzRWZ2NDJkTVdnamNOcHpz?=
 =?utf-8?B?Z1FhWlBwUzFMd3FVMVdyQTJxUDl6YzFPd3BCSlljSVdYTkZjbGgrZnFlTWU3?=
 =?utf-8?B?aExTd25zeDNZZXZZbnZySzJlbEthMGJrV1NkTjdjWTNWb3ZIOVJPNjg3WG5p?=
 =?utf-8?B?TFpQamJZQytCbzFRM3hhZGhyeGVYYmpMWTdVSkNTOS9JTWlNMTB4Y0xXcFk4?=
 =?utf-8?B?cllkczJaZnB3YkcwWWV1UGxKRDBoY2ZPVzlnVmk0WElPaGt6aEIxeG9BSno5?=
 =?utf-8?B?WXdmbHNYb2dyd0JzOGxNcjh0S1htNXVuc2UzUFZaNWlvQ2p5YzVlb0JSTVd3?=
 =?utf-8?B?VUJrZ1dyaDEwTVBieWdMU1BXVVF0Y1NzbStZVTkvWXAyVGhaNlNIV1lNZW4y?=
 =?utf-8?B?N3VLOU05dFFZejRjb2JXMis4bVJQVDBLMmpKRXdJYW0ybWE3YmJwRzJEeHY5?=
 =?utf-8?B?OEk3Y3ZMUnl6dzVTc25RQUdieUlOMkQ3Z3hOZ3Q5a0g4OTdGSnhseXZqdml2?=
 =?utf-8?B?L1VzYSs5SDNVWW9uV1BlcGpXQTNGa2FIMkd1elc0VG5yeG1nZ1E3TU1ReGZ4?=
 =?utf-8?B?aEREWlNuTnVGUnp2R2thZHhvVzBoRkloRTVWOHhWZWMrZUJnVy9TYnRjbllC?=
 =?utf-8?B?WWpEUFkwTFNxVGVYZ2xpZlRaSU12Y29qR283TzdDMVIrTnpORmF0aENtNHlV?=
 =?utf-8?B?dG9nSkJEb1hVWlJrR2N0Vi9kR3FzTmhUSXVwM0dSaU9XQ3ZxNXpYQmxmWGpI?=
 =?utf-8?B?SEh6RmQvMC9tSDZJNWN1T2dSR0RVdktCYUs3aGFXVDRZLzFVUXByZys5THNi?=
 =?utf-8?B?bzNNdmJKNnFKaitxSW5yUnM0eXdrK0tEOEw5UlNYNkYyMy9PazI4dWZPTHh4?=
 =?utf-8?B?R0JMTnVaREh6NWw2L2RUMTdmaityemtMa3pZMFd3MFp6RUtlRFhSaVZiWXJ1?=
 =?utf-8?B?S3lHa1FSUjUyek0rTHB6YW5VU21ENkRWK0JNNVd5N0tmTnQwUG10WXdKSWJ6?=
 =?utf-8?B?ZlIvK0F5V3VGRXd2NXppM0pKZTVHaW5MSCtETHE1ODg3aXZFYWhWNVdXYmI4?=
 =?utf-8?B?N2lCU0RTMHk0dzJiQllCOTNZR1puOGxnWWtqUHhwYk93VlJ5UlJhS0gwM2NL?=
 =?utf-8?B?b3FlNGJvc3YrNHZlMmFVZEVkdzVGbXdXeEhCS2l1QUZBVWZLYW5pUFZQUFRh?=
 =?utf-8?B?anFOaVF3cFk0cGh2aW5MZ3J4eVYrTC91M05xSlEreDcwaHRmMW9KT0pvRTU4?=
 =?utf-8?B?ZFgrZE9ibHJxNEMxaWRJcEhlSFZBb3dtVE5veFViUGxZaWpFMjBHK2RqWW9x?=
 =?utf-8?B?RHBGL0RVc1BxWS9lRVJvMWNuaWpvRUloL2dtTHJOUmY2SkxXcy8vK3U3SGRX?=
 =?utf-8?B?MmlMbVl3SXNJOG9BNDMvcnBlKzg3TjVZY0pLRGRFQTBkU0lzQjVCdFJ2blJt?=
 =?utf-8?B?V3kvOU9jNFhzUFRna29DaWNlaDlselI2MmVneWVYamRUM25BZEp6Y2xMOG1W?=
 =?utf-8?B?U1lXNWNWTll0OEovWlluaCtYcmF5cVlIVlNYNG00OVI0WWhKZWxGRmNrd21F?=
 =?utf-8?B?OU1Hb1JUMy9aeW5LUjcveVpuNFFPK2ptNnpUS1F3K1NRcWdDT21Ta3JxK1Jt?=
 =?utf-8?B?VTJwMGwzTTk2M0JBK3liOWYybTVGR1l2VUNBSzBUZ29CR0dFa1gwT1FMNVRH?=
 =?utf-8?B?Q1ZISWR4Z0d2bkdWalRpeno0U2tFKzk4ZjlkR1NCMnRqeVJ3Nktkc0p6MUFr?=
 =?utf-8?B?MXFwOTMyVzdZaFhEcHdFR0VZMXBveVJJK3I2bzZZVlhmMEs0VG0ya1Flbmk3?=
 =?utf-8?B?dUN0a1ZWTHJxMVFERmhRSXpGMWVqNkt1WVJMS0ViQ1VTdUc0VnlSUCtZaEpa?=
 =?utf-8?B?L0NSa04yVjE4ZUVBSFRTcHlta0ZTZElkZ0dWV29LUlBzVFlSYm9PNWVhazh0?=
 =?utf-8?B?djFMSG0zYjc3am9yY2dnVHdxa1NHY2hKVm1oa0VXM2tORGNwT2FNbkJDelEr?=
 =?utf-8?B?bUlvWVk5YWRhMVhlbU1LNmFXU0VrOHl6RlpkeHRzMnUyVkdXdmpBbXJzV2tW?=
 =?utf-8?B?YXV4c0VqMVNiY0xDWlpqWTFBT20zc0VvdHl2REFFU2o4L0haUjBvMHJWOUhu?=
 =?utf-8?Q?6QFUZXPs9J5aHcGZMoeT6e51MiNFVN01VuFkAz0kxQ=3D?=
X-Microsoft-Antispam-Message-Info: +5SJzXiVF+LhJwGcgAdAxasiq39ukEOzY6eEwC2AFtbqlyGW6JQ3TBDJ+A8eVN9vM9To0VyaVRY2dyLSr4cC+x/NKrsUwW9b2J9VXg3ycMCp314XNBZ7nNQSmcgbkjsDzri9GA2Oay/Q0UbbX3sj7y0vleOs9ns/1TZxq5oE+onkfhC0VXA6Xw4E38+JSFzX
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2365;6:s8TjCpKYvUlGp3D82CcNorLQseDUUDLyzDfgR17pGZDSfIztOCfssdSX/zPuNlMmhYyBbe6Xugg1AXTF8hJiPcJ0b4zhWaD8wLIpTswMjs67Ay9h4HCZUe0UvJyKsHvSryEEpe7fNfRjvTUP1APQ2fp/WU7F8LN8oSI1BNSpNR1GrSSKeX10xySvSWBxifHZomPskCjV3l4F2h/rR4Wg7DY8K0+iYyClcAEfg4/SZOJrWi4Zhmwo1bWWRHi7jdFEqOWvXTfyR1fXUGWpvQqfAhk67gxeXGJ1JON+y+5uBRYWLp3VuMWLqk+zyFm4jONoQNrVK8DUElYJZx7zb8XGvIaO2+d/7GLgRvINlPI9lRW8+26iMkTOjZ+XjG2cT2wxE2BwSz2LnVBty5BneM2jhsZ66fMhFtu+YImDaLOmSdn4OgcdNQi4/Td+0T2E/nvIw52zk83571D9wrvKdy/eFg==;5:yweysPq56mvyf36DTw5nwG2gl/HY/vF+pu4hmE7P8hlxJIDrwzsL2GqWOlw+HyKnwoVXk1v3AB0svFDNRfwnjsm0wo7D4d6mQsxO+XnPGjkrZa3taw0BLyKOgeJFb8yInRQWO0W57p0mpptsrgVXD/QYT8gaC8wBxRZEuv7BqTg=;24:tMck789fWSbdoAZ/WJoIX1HQApSVlj/MiSaIakRdNZXTbt16CHLidSGGVB+comtmCMIejknGdu96pClellMHxVX96jic7JTbePtxAh9snrY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2365;7:yaKjypx/eLK3XL2GtAEHOKwarTJlrkbCWIhQmPeJ08bHapjgYvNrEM3Y+1RNotCeRz0V7B9Z1prDKBV4sxW7RrC9SiSUK/EhbuARAHeQlMh0C91ZG7FgEGyn2UDLbh4huBALVQ5f7RThl84JeCbhLOIbAIe2wH8RaZRuq1mDteZ3Q2ANVeumdJmv2LSfR7ND3JTQ0o52bggELf2Wt6XxoWNTSY6va+VHJmjNFBNEh7fzgH0hb/7hIJ7fBIxVqvAw;20:rqX5Sp8FWu8R3/MctifYHhsau80ou7JHkIVvx8wSCG9QJA65G/5g5sFAkIwDLqZWDqKGzP7SU9R5WlI/W2UfvIxD778+VDVRNRlQxnQ+VBPbSfopjqtpzz7iPrjZHWxmAvlC5RDr19j2YwCPE5WBG017YF/bCYwwYQqTI6GvTmMzVQp55XFdYgX0yFT8Fpt3uIakQAsGWwzMTYGQDpDf8A8KPh18mydMCl7uJccJohCUvgCVWK8Wd/3aMPz5FQ3Z
X-MS-Office365-Filtering-Correlation-Id: 9bc19ff1-0448-4e1a-bf23-08d5b1786535
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 04:34:55.3911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc19ff1-0448-4e1a-bf23-08d5b1786535
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2365
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599296505721371971?=
X-GMAIL-MSGID: =?utf-8?q?1599506746469166076?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 5/3/2018 10:10 PM, Daniel Kurtz wrote:
> On Thu, May 3, 2018 at 1:33 AM Mukunda,Vijendar <vijendar.mukunda@amd.com>
> wrote:
> 
> 
> 
>> On Thursday 03 May 2018 11:13 AM, Daniel Kurtz wrote:
>>> Some checkpatch nits below...
>>>
>>> On Tue, May 1, 2018 at 2:53 PM Vijendar Mukunda <
> Vijendar.Mukunda@amd.com>
>>> wrote:
>>>
>>>> With in ACP, There are three I2S controllers can be
>>>> configured/enabled ( I2S SP, I2S MICSP, I2S BT).
>>>> Default enabled I2S controller instance is I2S SP.
>>>> This patch provides required changes to support I2S BT
>>>> controller Instance.
>>>
>>>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>>>> ---
>>>> v1->v2: defined i2s instance macros in acp header file
>>>> v2->v3: sqaushed previous patch series and spilt changes
>>>>             into multiple patches (acp dma driver code cleanup
>>>>             patches and bt i2s instance specific changes)
>>>>      sound/soc/amd/acp-da7219-max98357a.c |  23 ++++
>>>>      sound/soc/amd/acp-pcm-dma.c          | 256
>>> +++++++++++++++++++++++++++--------
>>>>      sound/soc/amd/acp.h                  |  40 ++++++
>>>>      3 files changed, 262 insertions(+), 57 deletions(-)
>>>
>>>> diff --git a/sound/soc/amd/acp-da7219-max98357a.c
>>> b/sound/soc/amd/acp-da7219-max98357a.c
>>>> index 133139d..b3184ab 100644
>>>> --- a/sound/soc/amd/acp-da7219-max98357a.c
>>>> +++ b/sound/soc/amd/acp-da7219-max98357a.c
>>>> @@ -36,6 +36,7 @@
>>>>      #include <linux/input.h>
>>>>      #include <linux/acpi.h>
>>>
>>>> +#include "acp.h"
>>>>      #include "../codecs/da7219.h"
>>>>      #include "../codecs/da7219-aad.h"
>>>
>>>> @@ -44,6 +45,7 @@
>>>
>>>>      static struct snd_soc_jack cz_jack;
>>>>      static struct clk *da7219_dai_clk;
>>>> +extern int bt_pad_enable;
>>>
>>> WARNING: externs should be avoided in .c files
> 
>> We don't have .h file for machine driver and It can be ignored for
>> one variable.
>>>
>>>
>>>>      static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
>>>>      {
>>>> @@ -132,6 +134,9 @@ static const struct snd_pcm_hw_constraint_list
>>> constraints_channels = {
>>>>      static int cz_da7219_startup(struct snd_pcm_substream *substream)
>>>>      {
>>>>             struct snd_pcm_runtime *runtime = substream->runtime;
>>>> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>>> +       struct snd_soc_card *card = rtd->card;
>>>> +       struct acp_platform_info *machine =
>>> snd_soc_card_get_drvdata(card);
>>>
>>>>             /*
>>>>              * On this platform for PCM device we support stereo
>>>> @@ -143,6 +148,7 @@ static int cz_da7219_startup(struct
> snd_pcm_substream
>>> *substream)
>>>>             snd_pcm_hw_constraint_list(runtime, 0,
> SNDRV_PCM_HW_PARAM_RATE,
>>>>                                        &constraints_rates);
>>>
>>>> +       machine->i2s_instance = I2S_BT_INSTANCE;
>>>
>>> I'm not a big fan of this approach, but I don't know any other way to
> tell
>>> a single "platform" driver (acp-pcm-dma) which of two channels (ST/BT)
> to
>>> use via the pcm_open() callback.
>>>
>>> Mark, can you recommend any other way of doing this?
> 
>> Hi Dan,
> 
>> There have been couple of approaches worked upon this earlier.
>> 1) To compare cpu dai name to get the I2S instance value in
>> acp_dma_open() call.
> 
>> But, Mark suggested not to implement this approach as we are comparing
>> dynamically generated cpu dai names.
> 
>> 2) We added i2s_instance parameter as platform data to dwc driver.
>> By querying dwc driver platform data in acp dma driver, current i2s
>> instance was programmed in acp_dma_open ().
> 
>> But Mark's latest comment was to implement platform specific changes in
>> machine driver. Machine driver and Dma driver should exchange the data
>> regarding this. We accepted this and current approach is based on the
>> same comment.
>> Below is the reference.
>> https://lkml.org/lkml/2018/4/18/597
> 
> Yes, I saw Mark's previous comment, but what we are trying to implement
> here is the SoC specific binding between i2s channel and acp-dma channel.
> This is a feature of the SoC, not of the i2s controller, but also not a
> feature of the audio configuration on the board.
The binding of channel and dma is soc specific but codec to channel is 
board specific.
These linkages can change from one board to another. Machine driver is 
specific to a board (grunt here) and dma driver being common for various 
boards (but specific to a platform like ST/CZ here). Tomorrow there can 
be some other board with x codec linked to BT and y to SP.
Hence, machine driver should send this board specific link information 
to dma driver for it to dma on the correct channel as per the board.
   For these SoCs, the link
> between DMA registers & I2S-channel is hard-coded.  The machine driver is
> already specifying which i2s channel to use when it configures, for
> example, '.cpu_dai_name = "designware-i2s.2.auto"'.  The i2s channel
> selection already implies a particular DMA configuration.  It seems
> redundant to create this separate out-of-band infrastructure to make the
> machine driver also tell its platform driver '.platform_name =
> "acp_audio_dma.0.auto"' which i2s channel it is using.
> 

We could have decided on the basis of "cpu_dai_name" but the decision 
would have been based on dynamically generated name. Though maybe 
redundant in nature, but machine driver is just sending info to dma 
driver that this codec is playing so play on this instance.

> Perhaps the acp-pcm-dma.c should register two different platform drivers,
> and let the machine driver pick the appropriate one (ie,
> acp_audio_dma.0.auto or acp_audio_dma.1.auto) depending on which i2s port
> it needs?  Then each of these would have its own
> snd_soc_platform_driver->ops->open() that could setup
> snd_pcm_runtime->private_data appropriately?

I guess it would be overkill to have 2 platform drivers one for each 
instance but actually for a single platform.

   Or is there another standard
> way to have a single snd_soc_platform_driver handle multiple channels?
> 

Don't know if there is a standard but would be interesting to know how 
other platforms handle multiple instances.

Thanks,
Akshu
> -Dan
> 
