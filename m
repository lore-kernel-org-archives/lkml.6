Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbeFETFL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:05:11 -0400
Received: from mail-by2nam03on0053.outbound.protection.outlook.com ([104.47.42.53]:64864
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751968AbeFETFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:05:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com;
Subject: Re: [PATCH] drm/amdgpu: Grab/put runtime PM references in
 atomic_commit_tail()
To: Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, Shirish S <shirish.s@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180604193509.29153-1-lyude@redhat.com>
From: Harry Wentland <harry.wentland@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=harry.wentland@amd.com; prefer-encrypt=mutual; keydata=
 xsBNBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAHNJ0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPsLAdwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2zsBNBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAHCwF8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <ab9feaf1-773b-990e-5fc8-34aab0e17603@amd.com>
Date: Tue, 5 Jun 2018 15:04:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604193509.29153-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::24) To BY2PR12MB0178.namprd12.prod.outlook.com
 (2a01:111:e400:585a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0178;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0178;3:wXcOTGBljDAyEldOg/rR8GNkviUYJoNcjfxk0I9QVT5Q495kO8zRTtT9c/TTGm/edH80O6kM3E5wmnawu8xPdnMRkBWaFlhFkZ6Sss2oKj7POvdq/8WYW/Wq2l5n+1YxnQlRK8iaxKfVB6LdR32caYyKxe4bmaL4OVOfpg1w3PI+QZ7lWn9gykK0/9jUaoezVFpp1/f+kZ17vne4045tGbzG58zK/IkN46HIFS0a5dI+vdiFUOelsbgci8AhubmO;25:kvhSoQQNgHaafife6GdeRXc93uysjiJ61kCSbCyQS4F7duSEI8x+ohb5zIgHGXW/htgrxkiFXpLZ3/8G+oVSm7G8GnyEsDepnNbgUbYdEPs8MaGi7Su9EEBI5HA0j0fxHFPNMEir6JAfueX1qMEM/j7VCNBAL/sjJZf5hQNwXC5+MGHjWHrHJNk1Rx2vu1NM5UXO06nevzzr+J4ECe8knPbl70VqtGzzXMy4Nhj0LmyqlKPR7jeUgNRvUZI9TNZzBWXO32AS4ymSornaWRGCyuhrSkoYGUVWVbhbdyX1sbEon9DoaecUsT7SVLYEFi+asuVEnQgV61h/DIaLzl1I0A==;31:MzToMykY4Gz+bMn2N1QkyMjiUoee5uhN1end0RWhP0vukidDWZbZYzNnc2UWrt+FfZK2+JKD6DVIro4oW5LebFDZ7Hd9gviVNf0Khef0V1TZVQfgYMjxLDq6keDJTRk5NhiqbvI2837X/P+bpibfptMBf+t0SKpNXAdv6f66DfV4ZlJNwXHL29/omshCqxWbcvqx4QJmvN8hLCOVt0/552nmeU/2KWgj6/lfKiViqdw=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0178:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0178;20:iHvZ5xszt5mhrmZbaiRVtSgJlQ6Is+MrZ9dXr1GcBfH1kVufd/V+SQ1r9SWQuAsL1vB9WHLX74pBF8UFzowvsO+FqtfC6IJITTpcsmBNYwPZ5LMj/TjC546aqrbFtX7f8BDbHAXMIS3SPOPdR7aIgyxX0aMHd11VYjcl0P5u88ldMcY5yssniPzYytMPfMv/Eto6jzumObBvIMkLMzvQRUui7FW7dZWDzY8bh3or/g8s863yu/dxlmMkonZgdIRkllAwx6P4U2XB8Y/G07iKnsfe5IIOaBsT3FyrdiphIkIgQIaQcPDBVytZzoy0eaqTvwLes8KWmmh5/3Tc9Gg5fPSRS+2dkaOI6NxjgyrtRf9Wg81NLDHLeDqmFDfU4AWJufhjAceqYX27G59uu4GsSLzWxdQq0shXMFR0IbtB+VWjNUN8vYjVcT/lhn31gHfiNH2M9tnEQBSfJLkQSeq4ArHJLMfapy5H66vuxC7KkIZTPsyrESFhym3+AFnEgfdF;4:yJDf9T/75NlukWzCoX44cLrQKyLSCezPTqOY2XDM/thVlMAQhgV8CHdH2c0G3KB+ihBp+4gnYxFkEsiJq6Q8NMpnAqMdKIWMJ+AB0oEjpE4WKyy/iYv53kPNi2jFfFWsZWUJai8bEzeYweC6RRy7n1SHYr4QPQR0zxnjZ4x7l7Xy4bI6DuF1mf3EgNijZryHHwu4wJoqoa5W+Tm5CMml2qaaIuJM3C7HUljmzhUQoZxu40UtSQJ7nU0hCgUOXVtWO5XpWZcPhIRZFS0AFN0WYN9ZV3W8PjHP1I9FEPROnNULRAQvLHuTbgnkCNvnbCWZ
X-Microsoft-Antispam-PRVS: <BY2PR12MB0178CF642B4D0E5F743482988C660@BY2PR12MB0178.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR12MB0178;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0178;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(376002)(39860400002)(366004)(396003)(346002)(199004)(189003)(16576012)(68736007)(31696002)(52116002)(5660300001)(31686004)(2486003)(86362001)(25786009)(66066001)(65806001)(65956001)(23676004)(230700001)(6666003)(52146003)(486006)(446003)(316002)(47776003)(11346002)(58126008)(65826007)(8936002)(6116002)(72206003)(54906003)(8676002)(2616005)(106356001)(476003)(64126003)(36756003)(956004)(44832011)(50466002)(26005)(77096007)(7736002)(386003)(305945005)(2906002)(16526019)(186003)(6486002)(53546011)(3846002)(229853002)(6246003)(105586002)(76176011)(81156014)(81166006)(4326008)(53936002)(59450400001)(478600001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0178;H:[172.29.157.77];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwMTc4OzIzOjVxaE9ZV1d6Z1ppdit6ZlJhcWJpUkxLTmx0?=
 =?utf-8?B?a3FKOTh3TFpmc0ZTdWtNZ09IVEJNOUJzSXJlRHYxNis2TDVwKzFEem00RE4w?=
 =?utf-8?B?c2E1Y0JvWUlBOVE4NXh1MEhlcGRHcVhuYVJOLzRXWUVUSzFmcytNZmQ5bVgv?=
 =?utf-8?B?MnRJVTZKVVVoRTBwUHQ4MlNPZ3dwNWhJbXdTZEw5RitFOVJDQmdjUVpGWktn?=
 =?utf-8?B?TTBRYVBFSTVtT0J1bnJLelpqck52KzA0Vnh4OCtuZFptRUJKRzZDcUd3Rzlk?=
 =?utf-8?B?Rk51ajIzeDc4dXA5cTVCOWtVdllBdzBFTjlFRFRza0RPMjBNSk91LzJMbUdG?=
 =?utf-8?B?WXZ3aFdCVU5xY3ZpQ2xIckxxczh5MklLbW5LM3l3VENMMHhNQ1NOMkszclg2?=
 =?utf-8?B?Zk5sZ0g1ZGZOaXkrcXBaQXhpT1gvUGlsbzRkV3BQanVrSjhtMlg0RXFOZkhq?=
 =?utf-8?B?R1V1VnowdnhHamtXV0pBZzFmc0hWdW4yOFY0Q21hRzdEYVlDOEdVd1Bxc3dQ?=
 =?utf-8?B?TFNVVnI2TDVERWthemRXd2w3ZC9PU3RRWTl1NnpsNklpS29GU0gyS2pVUjBH?=
 =?utf-8?B?aGh6NGVQOGozT0d0b01zOEE0QmpWOXF2STVKaHhjYmFITG5iNklXRXhGaDJJ?=
 =?utf-8?B?MWFxa3k4NG5rN0RiQlU5Y2RuWmVHQzJiYitUK3d6WjBmMEtzN0EwNzVqRzQ5?=
 =?utf-8?B?Q2RWZmEwUlFUSTJPK1p2NFJNTnNnMFlWSWpDNzdVMlB1U1BtazBtYjF5eXo2?=
 =?utf-8?B?N0JxVWQ1MGVqSXF0RDNnS01acHdXOFhGRlFNNlJUL2lKNFowMWpOTzhzVDVr?=
 =?utf-8?B?cFFiOUJScDBNeDQ2ODdnTFJEVlFvRGhKMmpXY2tXTTN2Z2F6bG5PYllvVW41?=
 =?utf-8?B?a2VRcDRRVkhkaGFuOEtSd3hiZVorVC9qaGVMWGQxQmxINSsreTMwb2NhMUho?=
 =?utf-8?B?Zk1MNmkrL1lOWHZWaStuOC8yRzY3dWQxREpTQW4rTkFIUmhXdWE1ekJNWkFB?=
 =?utf-8?B?cThvczBvMkZxVDByVEE3L3lQZXdHWHdKQ3crYmttSUtJaWtDT3p0Q1l5SnJh?=
 =?utf-8?B?YmR2OHlqSXBtMlRkUEVQa29nMUhFSVpHNXRwTHRtNWFHcG5IdUhPdjRZNmxn?=
 =?utf-8?B?YXdlZkJDaWlvaXpHeFZ1UEw5R3kwL1VBTGpoMk04cUNDMzBhT2M3Y0UzK2lo?=
 =?utf-8?B?WW5oaFR6MkxId0pkbGFuV1o0WFBrVmg4TENiRmdCMGdyekliTFRLNXdEak5u?=
 =?utf-8?B?UWV5eWt2UXlwUTA5UzVDVW1xU0w3VUNWVFlZQ0VKUStab0lsK2k0bG9HYjMx?=
 =?utf-8?B?aG54d0JySU9zNDAwSFhCam1kZkhjR09LWkdQYTRWYWtPa3N2N2hmWTlTZzRs?=
 =?utf-8?B?UDcxMFJkdEw5VnZEQ2NBOGN4REg1ZzhxcEVMSzNrN0pMYXdPRjVkSWkySEFl?=
 =?utf-8?B?SXJneThKMTE0SjBNZnkwZkZLS2ZNcGdualZxOUFHd1VWREYyaGtjVklEMnlW?=
 =?utf-8?B?RVMrVFRnbWJXVXpsTEZRcDVkMFpJVC9ZTEZabTJRc3BuR053MWJLeCtGb0kv?=
 =?utf-8?B?TmhIRU1tdmVFQjFNcktteC9HTHhKZVRMTGdDNG5CbjU4bXhqZDFvc2xvMTJF?=
 =?utf-8?B?TG02c0lsMkQ4bnVqT2ozSzZYOVdOL3YwWGpqMmM5emdEUHk2cUpnNk1nb1dY?=
 =?utf-8?B?VlMwVG5PTHI1L0xEejNBR3pwTXNud2lVenJnNFVQTStWRlF3cjlDbitkd0Nn?=
 =?utf-8?B?bFZUNk85Vll4aFdxWHVBR3ZVcFFrOTFNMUVqSFNHRFN2NVRWdEJwbU9vcjNX?=
 =?utf-8?B?Yko1MUllc3N1dWdUdkZSSDZZUkhhVFlTMWZEekRndFdkbXcwb0s3aUUweWdp?=
 =?utf-8?B?enhTL1o0emFJTmphR0V3QlZiamx0Q1ZaQnFxUGJqRExlVlRBNlpxY2ZNaHdu?=
 =?utf-8?B?MjN4R0pRRmFkaC9UNnVhZEFrUE1kbXkvRFA3YzA0N3V6YkNTWTBFVGZUdVBn?=
 =?utf-8?B?THJiS3VsdS9hVHlpYTRyUUx6WENlS28ySXo5UT09?=
X-Microsoft-Antispam-Message-Info: FGcMNLCGNOrLTyasir5et0C2eCB37VlVE1AYB25jfDQG6QX/YvHLxv/BmZVXmAth1yw4427Sl2bdyO+6owxIh+0ZSSVk5u+vH6NOaHi6nmxNx0W6a1Ol+omdChpZiBScOK7UPi0EAmpgSFi4dwFM7QnegE7mUJZQ2sxO3LphgVJraKfmxjsYOih90108mKFH
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0178;6:ii9Wm+CODVQIOowPKpBRVgafR2AZak3blxqU3VZXJ0wjpFDtC1J7/i/KVa5v/+SqhqFKUW2tgDUOPdd2rGLLkhWw3IYG+QNpsSCexQAlnz9iW/Vwj3nz+nazQChfvPpqfcw2c87yEEvczjrCr/tLJ3bBBMbnsxoWedhPUFm3EY/fPG56B2jt9NndPQwveJe+ioZ86/WhGFC6/tjUwWV5riZVxaPoklJFkZ3yKJvG/3W81pBvnJ63LKgpP5DBaqvBx8bHAQY7xDjuSY+6oKNWczZcsWH7RU4nbdLyBtURPXgURDW90F3bal/DSsAQGiKZ9tbXTMzAoMw79qdTc3KVtcgAR0t0XQ9tKQut8OQOEDX+Hz2FeKDPTyr0YdMsJOIhjZjCGOUp3/XGqeja3RNjZMzDzeiYEHLGJvFyiwfp972dPpujfOerEHln2JFB+Wvq8a/GiRMDMyf8Zw0itx9Llw==;5:VJrMI7F9sjECtPkF8pxNzSrbCsEm8cL50HEjuy7u3uTG8DTKdA1t7uu+TUi0gaS7lT6GT5oG3QbqhT/Ny4onKH7hWz95PzQmSkjI6h8Nc35/WvExx3bwJ0Om/a6PPuugNXZDlxJO2T6Lz0rw0mgBGP60ePl7gAuhdWg6192qE2g=;24:DdA7ioqCeA6EDu76Nq8eLriGiEgOY20oRPOuOe2hQpgL3wUEaArKICKnpDMobkOqhMGhEa5nez9u7pxbq3fHpBr54aCUdZep3fuRLH4sDUs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0178;7:vYccpmgaBj18fVsu4TT0r0bIKJN1FfxwVRUKWSMb3/2Im2S/cmk5tqKsSNxN6AQ5di3zEx6Z//IhAJyyl9d7Bhq7wQCKiPMlr9iB0JSXknWWaNzUaiymTHR1704nuLNJeFDx4xetsyKZ0T3htYn2eAk/U4ueUe9gXLp5iA/cPtk4AhEwZRJU6lvMjjjAKIpQat9jG+YzflqOzsa8Cy3dKT+YO8JkIuD8fOznSp8WiJGY445TlbQbrpsk96pigNjD;20:m6NnUxVs/ytbd1w2EwiVABewcIt3fe2bD9pnffDFAYNYj+zrXG/IPcWWzn4MZIScXpu5gQVLrFKcIUYLVChGatnn9pJWuk2IuTCUpc0oFPRqDuE0yliDyzDVUF8DYzs7tU60s3k6Sq14bSJhgDXUgF0F8xd3iFNXyZI1A1vGj8CwHrsYjGkuBb5DWtBcVZjEpGAnUPXXj9I9OJd9pl4U3QeFXhrwSv0bgHq5WiQMhBKb32+Ym1PasZx2UigUPFxd
X-MS-Office365-Filtering-Correlation-Id: cc2d2d9d-03fa-431e-b1e2-08d5cb173ed3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 19:05:02.0602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2d2d9d-03fa-431e-b1e2-08d5cb173ed3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0178
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-04 03:35 PM, Lyude Paul wrote:
> So, unfortunately I recently made the discovery that in the upstream
> kernel, the only reason that amdgpu is not currently suffering from
> issues with runtime PM putting the GPU into suspend while it's driving
> displays is due to the fact that on most prime systems, we have sound
> devices associated with the GPU that hold their own runtime PM ref for
> the GPU.
> 
> What this means however, is that in the event that there isn't any kind
> of sound device active (which can easily be reproduced by building a
> kernel with sound drivers disabled), the GPU will fall asleep even when
> there's displays active. This appears to be in part due to the fact that
> amdgpu has not actually ever relied on it's rpm_idle() function to be
> the only thing keeping it running, and normally grabs it's own power
> references whenever there are displays active (as can be seen with the
> original pre-DC codepath in amdgpu_display_crtc_set_config() in
> amdgpu_display.c). This means it's very likely that this bug was
> introduced during the switch over the DC.
> 
> So to fix this, we start grabbing runtime PM references every time we
> enable a previously disabled CRTC in atomic_commit_tail(). This appears
> to be the correct solution, as it matches up with what i915 does in
> i915/intel_runtime_pm.c.
> 
> The one sideaffect of this is that we ignore the variable that the
> pre-DC code used to use for tracking when it needed runtime PM refs,
> adev->have_disp_power_ref. This is mainly because there's no way for a
> driver to tell whether or not all of it's CRTCs are enabled or disabled
> when we've begun committing an atomic state, as there may be CRTC
> commits happening in parallel that aren't contained within the atomic
> state being committed. So, it's safer to just get/put a reference for
> each CRTC being enabled or disabled in the new atomic state.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>


I'm not familiar with the runtime_pm stuff, as is painfully obvious from the fact that we missed that with the DC driver. That said, from a cursory look at runtime_pm.txt, this looks right. 

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

I'll pull this in through the amd-stg tree.

> ---
> As a note, I'm not entirely happy with this fix and I wouldn't be
> surprised if I missed something while looking through amdgpu. So, please
> don't hesistate to suggest a better fix :).

I still don't really like amdgpu_dm_atomic_commit_tail and related functions. We have plans to rework these and make them more straight-forward.

Harry

> 
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1dd1142246c2..361b81ef6997 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -46,6 +46,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/version.h>
>  #include <linux/types.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <drm/drmP.h>
>  #include <drm/drm_atomic.h>
> @@ -4211,6 +4212,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  			if (dm_old_crtc_state->stream)
>  				remove_stream(adev, acrtc, dm_old_crtc_state->stream);
>  
> +			pm_runtime_get_noresume(dev->dev);
> +
>  			acrtc->enabled = true;
>  			acrtc->hw_mode = new_crtc_state->mode;
>  			crtc->hwmode = new_crtc_state->mode;
> @@ -4396,6 +4399,16 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  		drm_atomic_helper_wait_for_flip_done(dev, state);
>  
>  	drm_atomic_helper_cleanup_planes(dev, state);
> +
> +	/* Finally, drop a runtime PM reference for each newly disabled CRTC,
> +	 * so we can put the GPU into runtime suspend if we're not driving any
> +	 * displays anymore
> +	 */
> +	pm_runtime_mark_last_busy(dev->dev);
> +	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
> +		if (old_crtc_state->active && !new_crtc_state->active)
> +			pm_runtime_put_autosuspend(dev->dev);
> +	}
>  }
>  
>  
> 
