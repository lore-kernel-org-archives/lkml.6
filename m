Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZobR3TKqS0dK+DV2lPZzHy+BqO35Au6YAWIu14n/uxi8lTrLCvV5wcxRIMdv9g2XgjL02YX
ARC-Seal: i=1; a=rsa-sha256; t=1525688363; cv=none;
        d=google.com; s=arc-20160816;
        b=wcloaqTw5IRUNXT7Ue3XimmBPr/NuVJgqN4swICZTOnTVEiUnR2bfepcRoo7JkNa9P
         U0notURk0CB3ehOK3QnUwXYZT9fBz7yUwBcJlmLHzgK8/npZEWLuAprJaZITfT4xTQ3m
         hBUIfGbGTqOsq78QLxN/aPgNmKdG7KSYCEdRxJ74zrlmS+KU7WpHTU9pBrCD2zosvJvF
         7D7PFJ3RJEz9NYYnNXWJxu9A1SgBVeL9wMuK+lF1pZmbmR+F2nsdueinmhkvESpPnV3T
         546WXYABKp6WSfyC64Cbvbus5P/PcWkzqtHj+djZDD7IIctYMr6d/TAJKo0DSkQQ2rGS
         2XPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :dkim-signature:arc-authentication-results;
        bh=d7wK6JHXN1aASlTP/Lnhyte0Kn7IyDbwDspl9FLFvSU=;
        b=tpDI8yj5IdSF8wD+SD5Izbwxpz+XjEJI6ch4NhThNCm2vzL9iAc5FCdmEN6lMaXPET
         Fcdv6RqjcReP/p3dip9+kJYc9zG93UBIpsGSn2RZ2gB8z6VUIljby+3r01gHV6hQz9fI
         DeZ6BQ0JgCz80kbkq7q0R9BvWJHtL2c35lY7bM6/Yb5F7R4JELT9B/hnktw9IJ0oOh/G
         TDXcyQQ68dQoVEql7Ek1Tq3lma/V5sGBudGLu3d1BB9e6Jl2C+KCJFPAakX15JegF9bG
         qj5LZOFineMjlRTB9Mm/nyjP6/lOwKeZJDi7Ij/9kdArnt0iPIfcgJ8KOxjlZgJ3aIbR
         hE6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=txMrHaVT;
       spf=neutral (google.com: 104.47.42.45 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=txMrHaVT;
       spf=neutral (google.com: 104.47.42.45 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com;
Subject: Re: [PATCH V2 01/10] ASoC: amd: dma config parameters changes
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jason Clinton <jclinton@chromium.org>, Akshu Agrawal
 <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>,
 djkurtz@chromium.org
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
 <e53cd47f-ac63-93ca-9751-f9185d94d17a@amd.com>
Message-ID: <b002a891-a098-9a61-b105-71519ddb05dd@amd.com>
Date: Mon, 7 May 2018 15:52:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e53cd47f-ac63-93ca-9751-f9185d94d17a@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MA1PR0101CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::17) To BY2PR12MB0306.namprd12.prod.outlook.com
 (2a01:111:e400:585c::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0306;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0306;3:bnE/YAsy/QY34eVwYjST8obIhl2x4D0u43Yf41eOjhQEyA8UkVrBjwB/tAmS1tUKFc3df1PqnNBj+KICTmHas4zAaXTT+3HOj8x/hFBdlbvW+N6MkniHfpj8t1qYDqwB9x1F7tEdXLJoxeDdE34krUYZ7Jd5M8/WtxR3r9nhDY/z9emodWmPWsR4b4tkZmGXcGtQ0bMCIKDIQTFc+wYNElzxZzXweldWHwi9V6vtitoNLPMUGItzRZTX0abdNYFM;25:QHBcIaHLOKx/EyR70urjnUJfAJ9f0v/XdFDdxXq0Nb35EsIAAEBPzi29I20o+ca0LzBeGp+5VF/99yKlAzRYIxnjk42i9h170f1R4uXkyHuBEOqPxjsvrzRy6B68EABYVFVD4d0bfGdir1oAHIZHeSVQFkoYM23NyE5WjRVK0um3E6o9S4hsFznXiQTruE5dUQBczRaF5/GGlDsF0IGCvC9brKUTSTBqY8ZFiZunHiT6w0Pm/jjgVBalSTQj4YHOxp4ScgwLOUQ0j7pG1YbqoaoWGGSVe5gjXQ1+A7pXPW+YDJ+ax+iJ6JCHGBbIQKmpZYpC906s0gEvmuVN8pWeCg==;31:TQRsbgQbwZhLdtGnQBytgLcSQxjtnUl2YZvWu0MMthqekSzaHYeUTG1RZkbT7yEqF/313skC97RoJRk//yLbna6pmzSRHOKHL8vz1xpGC+HN4281Atj/iIHsvY4kCzBzksWNFzcCi1XS9iZPJfdC0DHZdbu8AEPFaO4cMS7GfzdfL1vl6PiapbAJZ+ouykBYWL4KgKPS2F6j2WCo7Pqsw/ethZ5k/gpVY0kSTrniwN0=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0306:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0306;20:76OULT2OZHsDJlXH4F7qKHMm3EvkBDl8/mjEwwcCnh560Pm0zPHWlLZcwtfmU101plN0G7juZvjBygZFbdlyGCb4ehRD/w9F9FB8MH9TfLYeaRsA14QyrRkJg9hjkxCiUpP1EmMzMvhTBVU6LBsKu4Xs6leMTh1+fpfMOU+BCJbzpfJ/qNMiGEErcaIQv+2wlD8zSIYWu/EyI9xmkeWX67LyT7vTdaymIsmXUnH8pJcC4freylHrn1/OtbR4INacz+U5M5equ+naT8vyqDh6EQS71ZHnnVKLXA9lueSbvoTLNtvMimt/r9WAjD6sKEwRScopv2ciq/H65B5vsA0zyeuRm1a5IcxKqedWdN9EC55bkumd7Iy7/X2uOzS52LXeXJ+m4p1G8vrlJH0mjkNQ0vz2QJ58zw+ML6pnccee8QODdxks6XnwT/7zTMY+hGQn9Q8ZcTFJGfn0gZTyJrSRRUgZ7Rx5qwO0K4eZRIo0QIUeUY5ehu3sct9Am6xE+W2P;4:mLOeToVR76yIT623s2hoXs9Dejjia+XxMcyGZ2WG8dGmow7l7bdYeZE6H/TIqn9BvdEARj3xN7sc347OYa4OOUA6h2fW7u6thhbuGcrxAqAaXeCt2hh/lp1qWgGlsoc2/T8Q2qluG42ulH+9SoIlT5uNpGPc8EJOp2VY7PEB5C6AIEt+FndMrHGaBHlzErHxekmwprrHk/4BjRQEfl0roqJse7HSeA4JrUphtMzzmE4dJ+Q1QqJfFEVwU6MkFyhPbL5IJ2ppprOT/7ipwh6HnsMHrD6nUpVgX9PoXqzBr7MbO9LWUwFvK0LlmWjleUtE
X-Microsoft-Antispam-PRVS: <BY2PR12MB0306FCDDFA654D10EDAD9CBF979B0@BY2PR12MB0306.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:BY2PR12MB0306;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0306;
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(376002)(346002)(39380400002)(39860400002)(199004)(189003)(6306002)(26005)(6666003)(16526019)(53936002)(316002)(16576012)(186003)(76176011)(67846002)(52146003)(36756003)(52116002)(86362001)(966005)(97736004)(25786009)(478600001)(54906003)(39060400002)(4326008)(6246003)(77096007)(72206003)(58126008)(229853002)(64126003)(476003)(2906002)(81156014)(2870700001)(7736002)(8936002)(81166006)(8676002)(31696002)(486006)(446003)(11346002)(105586002)(5660300001)(956004)(65806001)(6486002)(386003)(2486003)(23676004)(47776003)(106356001)(6916009)(50466002)(31686004)(3846002)(65956001)(66066001)(6116002)(68736007)(305945005)(65826007)(7416002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0306;H:[10.129.12.246];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwMzA2OzIzOmhuZlMvbll6TkdwNnVDSnpUOWQ4Qy9BSVgw?=
 =?utf-8?B?eUxXM3RBMUhVYXNBMnNGU2VvRDF3QUNGdWtncXJLUk9zN0FpNXUxbWNoRWg3?=
 =?utf-8?B?REdkdHdEakdOaVljeWp3M1BvUXcvWC9kQytCT01iSTNlSFRIRmVYUU0wM1k5?=
 =?utf-8?B?aXZVVmhQMEQvV2kreGNmSUtnMWtpakRhTEcrNE9UaGxZWkNiZTRJL1RXdUdj?=
 =?utf-8?B?K3lVVXVSZE5mNk9qODBhbUROVGptWHcxRmhFT2VnYlF2NnY5N05ac0Z3TlZk?=
 =?utf-8?B?d2MzVXcrZ3hjNUNZUmtuVHl1NWtPdzdqQ3hoUVJLQThNNHgzZnlveUdzMEJR?=
 =?utf-8?B?aWRWNXYzaE9lQzlMU1FoNloyZENzSXhwRC96RWlGcjMzb0FkT0t3dytvZFcr?=
 =?utf-8?B?dXE0NTlqQnZGdC9aeVlaam9taFo1T3RyOUlwc282UlErNDk5cVV2OWRLVEVy?=
 =?utf-8?B?RUFpbFFRZ0NGODRzWGVkaE9oZWIwc2ZPbkJ1Yk1yRTBUYWkveW9BUmxkc0Ez?=
 =?utf-8?B?T0F1T05rK1FrRWNYSGNjTTZYUGtWNU9oME10T3VNTzRDb3Y5MzBrNm0rWUVp?=
 =?utf-8?B?clZSTzZ1R3VXRWs1ZEw2eUNieFpXUWkxNkxFUVMwdmRlOVZ1U0hZVmovcmg2?=
 =?utf-8?B?dzc2amFVR3ptNDR1M3VRSjBkWlp1UTFpd1pRUnMyMUlkaHVCUFI1STBPdUxR?=
 =?utf-8?B?ZUFzMkpSaldzK3d6cFZROUlzZWEydTBpT2ZXRG9aUmhwZDZKUGxrOEJMZFFm?=
 =?utf-8?B?SHVtZVpqanlvTmJMUnJVMThLVFJvZ1hySkRoVlFhWDNqTU9vU0RhZkFzb2R1?=
 =?utf-8?B?YkV0UmIvL2l1d1NJVVU4OFh3OVNjWkg5bTYzaVh6NHE0OHJHRUVOelNTNThu?=
 =?utf-8?B?c0pscTYxN3RrR2hEQmxjdGJNdm82eDVlb2R4bkZ5N1JOLzRHNnRIa1kzYzM0?=
 =?utf-8?B?cytGV2J1V0N2VmdGa1IrRHJZTitKQXg1Z2lib2JueWkvdUYyemFTVldJOUo2?=
 =?utf-8?B?TGEvNGlJSmdvTS9sZlByQmxZdWtvL2txYUFLcGNyZkEyTnNvWHh5RGRTUjE5?=
 =?utf-8?B?SGR2dFRzZUxLR1V2d0Q2bHBNdHRwSDlKdlVMbUhSam9WdkNQOVBSZkNQcVlX?=
 =?utf-8?B?VjliMkV5SUFuemFheG1MYUY0eWtvZDZxRGNNM3gxVC9ua3hndW1MRHFYRnZm?=
 =?utf-8?B?Y1NjeUlGZVlUaHNibVRIWEg5a25xV0dUVlpMQSt2bTBsd3N3akxqNGJlUmdM?=
 =?utf-8?B?WVpTVjhUa2ZRcHNpT3JNNjQ2L21DeldsU05FaGtZak1BL3g3alBNclhmTEFY?=
 =?utf-8?B?VUZWY0dOb3F6dFlwb2FPYi9tTEVCWWJwWTE4aTZyOFJjZkI0WG8zMVNORnN6?=
 =?utf-8?B?S2ZEczRKUE5MaThwdUZmVU1NS1dLZENUWHQ3N2RYb1I5dDVtaENadkdDVmI1?=
 =?utf-8?B?WGUyVU1FTGtncE9QY051akJkdldxcjZ4Z29aMVYySWZlcDlSUzFVelpWTE1B?=
 =?utf-8?B?Vk4yc1AzTWNOZ1JTUWUxWXgwYlhBTzF0Sm8wWDBkRVZWVlhGbXRTZEM3Q0hI?=
 =?utf-8?B?akZHNHNVdFpnQjZYMGhCaXlZMDU0ZklQTG1oTDRQNkN3ZDhBMnBubnBqZ1A3?=
 =?utf-8?B?U1JUUmhwb3NrV25Ka05pUUJtY1hoTTF0bThBTWJsald3R1dIVnk0cEdaS25q?=
 =?utf-8?B?N1lTSzlsUTgvd0tveGtQNVBoa3RXblZXa3VQd21hZjNYMmozaG53WjNhT3cw?=
 =?utf-8?B?MzhpdWN6ajdGUFMwVEM0bEFxWG94dG8wUGg3a0JQQm02TnhOVE1Ra1Y4L0tr?=
 =?utf-8?B?ZU1La2FSQmo3TlNOc2tWemJOdTlBOWhuZHQzN3U5em5sYTV4cjhMOTRNOHY3?=
 =?utf-8?B?emdxNVVPdjJEcnFDek9SUXJ0bFBUTCtaWGNjT09QV0ZFQTZ3b252MnFqWHNs?=
 =?utf-8?B?Qm9FQURIaUwyRnhmYU1zemR3ekx5c1U0UHovMmRhazJGYmZhMVE2Mm1JSVNB?=
 =?utf-8?B?Rm9ZSThBTVJPTGY5ODJlQmR0Mm1wZlIrVG5LMGdYZHd3Q2syemkzTHczTWFS?=
 =?utf-8?Q?BrY7NBPMTCKi7gYFSyZ5kn9/Q?=
X-Microsoft-Antispam-Message-Info: xfqOJm2Hb8mmDAArjrKA0/9xz6aG/0RY0AlIMTrGTqzj6Z2g3+ewh9nqzX020cm2LGoGq0xWgC+ubs5gzRl9EQ9g5Bs8X6NkBruCd0PywPaA6WFleo6Epe25iUGvjnYn5c0nI/wcABeM3gujTotOcHHAX3j65RiWLxtObzTbHBhK/XvTunY5cGZh71j9DMsJ
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0306;6:pZtvPFiTqUrrM57hdwNuk1kXDpw7mLV/EI21VvRWebkHo5kVYLLdVr2sPhkxChMmiqNayUACuIDG+W3mKygliBUWjqQA5y8WoewPHDGIkeVNHDor/TjBMQcjhkEZDzFuVWZ5I+PL09fabfHiJf+kY7HxMckjvWg+l5a7v6hnwBX7SYF8jXuPlusioVPzW11nmRoqYK0f6vaM7//zT8WBZDPCMwjh96RIXH4UufL25Oj8ZjXgSXs6SOoewjFAhjz+rNXEYrg4GFTeg2TkOuH5090ZznsTELYCulVWOlnuGlMYXPMG+S274L+aOL1Qb7MmdDmTt9fsCJ+esnCbw1yRx2FQl4v3ouZOgeIsLlHo5wEo93LSrH8aeIKxcdrRczVcwKmvPDYFJF7+cDV5KDvbXq1a1Jp56bUMlKBq1Q29/XvlyITXCmjw9a9HZzL2UUBsSl3dM/I/vWrQldPa2rn8EQ==;5:B/6xWniJVegr6LmNYrBBRfQ3ef72aU6ZK3dcclCAgAGsnXzzy7+BZr+PEa/mULSpnO1lSLJDgiJ1fN3d+zpqIHD8EyEjeWIZdvjY8wddSKUFUCds8vny+i2wS2A70PAS/C9avXdtzb2q+KcZ2KYfRKpurJQvewZXFxCt8kk0BE4=;24:KGhYULneaoX17vVVsaU3i5RtUwVT6BrWkb9wIEWwS76GR/7oiDagtHhBzNI0iLXHk1C+6i/vdHb9RPA/RwjNALr/xIm8ape1+6nsS+zb1gU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0306;7:FO0LZ4G22WrnsRveqOpAAusWjkp5XaqwHOBX/N1A7OKooJ8ZvwoMioYgdhzcXuI59/a5HTRzE2wrkGAvX1w36SQStsoNCjgJM7yzUONMzlpjhasDKr3Yqv+lcKfjzxfm91wz2+eVzsuyMuIOS3Ha0DwfZ0O1HBhc8ms+cm//QFUZnNJqv4URWilZLx20T4vmvXiX1jtDm7rPSOhnVayhvyfGRzN6acb6m7ZRl1x+JmZgDUuj7a/6jg3SpctHuivi;20:TI9toDfb5asZq9zTxdi6dhicsWbKBPcppBvvdC5Yq3JCx4PTjgHNPv2vihR0J9u27yQOyI999hrwDBJjs6vAjP6z2izqze2CHvh/6RphofCFINRL19lujhwsITrs2WMClPAlxMSeK0edxr4Ks4g6dYnvS/HsKwHY5bDh98COOgnKrgatTuY10PvV92uE7D1aBxmtokRRvj2AEkNC/WeVfOOqbX9HKASwYKQReNLCLfbbCJfqqLsDQAsvlbes5/kR
X-MS-Office365-Filtering-Correlation-Id: 97380176-a5bc-44cd-457d-08d5b403ffc6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 10:19:17.3597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97380176-a5bc-44cd-457d-08d5b403ffc6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0306
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599296141928589066?=
X-GMAIL-MSGID: =?utf-8?q?1599800201399929161?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Monday 07 May 2018 11:57 AM, Mukunda,Vijendar wrote:
> 
> 
> On Wednesday 02 May 2018 02:19 AM, Vijendar Mukunda wrote:
>> Added dma configuration parameters to rtd structure.
>> Moved dma configuration parameters initialization to
>> hw_params callback.
>> Removed hard coding in prepare and trigger callbacks.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>> v1->v2 : Fixed capture stream wrong channel assignment
>>      added comments in dma trigger api
>>   sound/soc/amd/acp-pcm-dma.c | 103 
>> ++++++++++++++++++--------------------------
>>   sound/soc/amd/acp.h         |   5 +++
>>   2 files changed, 48 insertions(+), 60 deletions(-)
> 
> Hi Mark,
> 
> In this series, patches 01/10 to 09/10 are good to go from Dan, could 
> you please review and merge them.
> 
> For 10/10 please let us know your thoughts on it, discussion reference:
> https://lkml.org/lkml/2018/5/4/23
> 
> Thanks,
> Vijendar


Hi Mark,

After comment from Dan on 10/10 , re-spinning the patch series by
adding Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

Thanks,
Vijendar
