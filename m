Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753752AbeCFOCW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:02:22 -0500
Received: from mail-sn1nam01on0085.outbound.protection.outlook.com ([104.47.32.85]:36136
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753711AbeCFOCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:02:20 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com;
Date: Tue, 6 Mar 2018 15:02:01 +0100
From: Jan Glauber <jan.glauber@caviumnetworks.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: defconfig: Raise NR_CPUS to 256
Message-ID: <20180306140201.GB7428@hc>
References: <20180302143737.10788-1-jglauber@cavium.com>
 <20180302143737.10788-2-jglauber@cavium.com>
 <CAK8P3a2ORBU-_7=JeCHSuM8YtC7zeO1VPxQzny_8BrpyVGCKKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2ORBU-_7=JeCHSuM8YtC7zeO1VPxQzny_8BrpyVGCKKw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [88.67.129.238]
X-ClientProxiedBy: AM5PR0102CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::23) To BN3PR07MB2497.namprd07.prod.outlook.com
 (2a01:111:e400:7bbf::6)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c3aa167-f80b-4ed7-5b34-08d5836adf97
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN3PR07MB2497;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2497;3:8RYAIbA7F6UUvr1zU78WuOpGAaLzPfjU38yNaa8xX4PTlFWfsRPw2yQPnoAXNnG/cFuaXhzVlgvlfayKD8QWmE6VVhZaDOcL4tlQvsIhugRnb0NzwelGcYZTSfbm1htkAKpd3TWAChcX9/xF/pivhiJ5+Y9b3C+Be6wubJ0mcP9tCRXj57CRbwYfOVrPPBe6t+OG/tT3UNBETYRw5SlEVUNrQiTGZVsRD6n/iMN/yyTl3bv+rUdJ6flLoocXgoLZ;25:q+UmcOXlneIUK0jzdVZy+c7moBQvtsGJ0hUBR7mU8klLOa5q603SvQoImoDqwmYmt455MVce1GLRnbttTxx4lhnb7BpO+0ItaeKiLDmMfNubb1s7z+XnjNMQiHoJ/uLq6D7TPJ8HxGBWu/0lCCC8hFkiu//Ky9OtFRwjyqwCs8sEkC54Wc4bLDLj4pskdOQkCdLedwB+VNN5OP/mFndx9o0O//rsRGfHroZhssyRXSCB5T0i3kyvji/YmftiKig3OTmRetQRHvjmXNHN7+qZyRCbf73tvH1B43EmXh4TDAtyHdUiFOYjO+Xo8cTdZE5vtsOOqPf4nqXCOHQ3PVw4vw==;31:fWpvsWGqqyfyL18SP2z0EYgMtRgyK2P4hUeZVz+NzF5u7eB8qRfUue17ljNuDU14nZBDeF5jqzR0vXCy3QgUDQe4V3wZKUv+84TjovHKUzWkvcmiZFU6kbkZrBbYw1NO/Erx7FpjX84ARtXHmi3GxoiaJDzt1/coHYlei3kGR3QgIGxjV3k8dnB4AERrQPU7OkWECt4r6Gvqp/70cUYvvHj4flFhEaO1qXzukmlbaQQ=
X-MS-TrafficTypeDiagnostic: BN3PR07MB2497:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2497;20:mMWtPgBqhwZfUbSaSv6ilNUeepNewwEieVtOMVXKZfze1msQakcmcqmn/sqnRfbWvp2UCXDe52z3ONf+PqyWPFaDrfUGNd4sJhmSsxoGnBN3E1Td9bY0tzZwkT3dbiCuNS+BKzC2e7YlJnlxmci4ghZXOXdTkygB+XOsH9heo3XVaEGpoU/yCXxgbFfr0otH0lGcCso+hkeqlMgFuaEwNKBqa268QhfUt6PkVOKACPmYjJED96fey3dDjswzXk2jHsPJSambkPm1BoLdZGtz5FzD+Il+bIUhlbnt7xJtbnN6ddCUfxOy2shxCA3z30FoEB4uBnTXEv5nRmofKKEX6omm1cuuZF1roHiMHRDwpybq/RELKr5nkhbeXaRj9A07fxQOq+OQJgoLK1jby650ok4x0SaRQL7PP2L/NfaLSu42nCIxQI5E2oyYaKAYn1+eBPcXywRQ1zVcHEbFLsp6UZXLsxzrHQHDR5OMhCSRrQcgJ96VKwo2SVF7FVe8fWiRmSQrL0BDNIwnMNgYFdZHuv2/73mQ4AZ2x/LhGc7gEBrBjdapi1dnWAmuj815PqI6OEPYn5fC1DhRJom0p0YE5my0zvUydub+NpxrIAWyDw8=;4:fQhwuRKdMNGyWmzwSCJqjpS0P2OxP0xT+M3x/L8GdB04pPJTbRgUETVh5puCYvt23pXr9VWF4laQDoQ5PDLe5BkX5tSmW5iYmboGzwxuj/xE9WTTk6Ri1QmzLv5ZWx6pHVkoVAmGoV0cgQKupsrdHYE/hG6cMgZkYtRo8Nwyn3enSo2ArOvPMhnq3N1r9TSZlEyl4ZOGPDPJJZeb8TZNQOBIrCXiU/3vF9pM8Yf6KpCVrXkv2lIyujgSVnwqJAkvbtb5FItoRfWBseP+BJ8Tmdh1rTPApygK5CrbSIdLAXZNLXmI7pGHxWrUP/GQD397
X-Microsoft-Antispam-PRVS: <BN3PR07MB24975FD176E7984B0C64516A91D90@BN3PR07MB2497.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN3PR07MB2497;BCL:0;PCL:0;RULEID:;SRVR:BN3PR07MB2497;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(346002)(376002)(39380400002)(39850400004)(366004)(396003)(189003)(199004)(3846002)(305945005)(23726003)(6116002)(81156014)(81166006)(8676002)(6916009)(97736004)(7736002)(6666003)(2950100002)(2906002)(5660300001)(33656002)(42882007)(47776003)(1076002)(8936002)(66066001)(26005)(186003)(4326008)(53546011)(105586002)(25786009)(16526019)(33716001)(386003)(72206003)(55016002)(6496006)(53936002)(33896004)(76176011)(9686003)(52116002)(59450400001)(58126008)(16586007)(229853002)(54906003)(50466002)(478600001)(6246003)(106356001)(316002)(68736007)(18370500001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR07MB2497;H:hc;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR07MB2497;23:AOJD0PDBhYRb2mt46nYpbN8dl05DEHmg4IGrRA4yY?=
 =?us-ascii?Q?OqE8UY1zdDFtMxLu7yDZWxLZQen2hETKbLbQ08CRw6JsFuTaBGU4hD5v3caJ?=
 =?us-ascii?Q?crcKvf5EUIIMJeVOsoLkJ4JGpnjfFmXdXoXBuxhYI1Q92N9cuq+SkA77YBpR?=
 =?us-ascii?Q?QR65FcwT29uXN8YRK17CsJo0LgEu/YhXOaevoUgtW89/L/1HH2/sW70za4il?=
 =?us-ascii?Q?YHIatRNXMVijJ1gszgAXHuENjrrvRXxu/awy3JZ65jtQ9PethUpnY4rFpb9P?=
 =?us-ascii?Q?61YpDhGOx2tMSOIHdzjKTtrQzUyYOIyQ5pTrY0q3DpWuZAN1jdnWhK2O1/zE?=
 =?us-ascii?Q?LdlLGQ07904f2QuoBG0s2Zk/OXmw8MkfmZ59nLZXlfAdNy5p2Oy2AjWE6JRh?=
 =?us-ascii?Q?16LWFknLzsETkGcgbnSlHOx76lTPwXZ+N+dmYafJ2zFu0aUQDXGsQlqp5JGp?=
 =?us-ascii?Q?vbp7xtluwK8ygfjvU/f3rq0pme3mvBwD1I9XncUA6y9tiJuk/d/uE+CfdSHS?=
 =?us-ascii?Q?LYSvJMG2XP67sZC/gQxaMdN+p/HSDrpQTYY7zCXSB5+JyXZsSePvvu6Z4dK3?=
 =?us-ascii?Q?g+Y+3Fo/EGA9vgrmSRHSPkSZ/S3T2YsZlO851646JdUcNquf42zblujAKwXK?=
 =?us-ascii?Q?3IFC+TK2/TLLuexnU7L/9ls/hXNjLYmul2q4BjiKwCYS5qaifRFcQfuLogIN?=
 =?us-ascii?Q?IKeahH8e0zDPr+1jjnQsjT4pl++PEFwiCuasy7JmF07oSeQtSjIx/lo4eaSy?=
 =?us-ascii?Q?+XUOqBOGQilrUoV+/GKXHaluMZVMn8hXIId0iqQJqZ8HLzL3eRlvcOyx53AP?=
 =?us-ascii?Q?aNKJsuGSccgJi5iuKLU5+7YlI+b9M10m48XF0WabOxSguEDZOBl5onXdzt1H?=
 =?us-ascii?Q?KJFekzDC0wuTn0iyNtz3yuzBuSfPg1/Cwgbsp4Lipxshzzy1enNnlSYl2Tf0?=
 =?us-ascii?Q?ppsWWDeFbPniM67V8qBXHCs/pFtR2Ic6A4b0KUdv6tam0K61G1RIZRnI9DXV?=
 =?us-ascii?Q?Fz1X2o8U2K91bfRoSZMMxRz5DD84o90bX+NSlXmuDLHJ//dg9iFbFrJXRkWx?=
 =?us-ascii?Q?U7rn5CvGu1K4XDyjvtVDdrxDBW/cS/2BzS/xvuvcRjToZ8XvhCwTQrf3kegh?=
 =?us-ascii?Q?9UG1uFX9q5WlarTz7Lm9OU+tWdYq4t0GclG57nKXv7dDTTBhBYD+Oy/XqyrV?=
 =?us-ascii?Q?A7TglCS1X+tXE9Re1XuD7ZPNNxcMsjWajjC4zupvfhVp6lZUZh8t1XfsYQeW?=
 =?us-ascii?Q?zpkZD2s9Yd66K1azu2wvrrq5x0c8G0+fseabcCOyYnoPpEjSrfmm9yd5Ibh8?=
 =?us-ascii?Q?r3ueasllpRN7TnYQXYoMrDbq/0zvnGrjKgOx8oAnggGUX85ZF3pimo0/MIew?=
 =?us-ascii?Q?1vZf09GZEe4EFkbHvwWe1Rg9dHB8Wyov1zVSGiWOojxWsuK?=
X-Microsoft-Antispam-Message-Info: bNtsVPxXzz8gdpSYTV5mnYUO9Tixm5gP+0p/pkMUdiLp4SlCJh1E5+U2meV4GVGt7bDKf3yQpM12RQ4OR9lL+FqZVeQQ38u06KO3HsjjlqSIcL2AdK/T7q/7GOBmCcfWjIz1sS6Ev17eeIbeTGy3k44JsnVyNM0cZsOqkzYc3hVI8gNkiBmHNx/Zyi8AGgnw
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2497;6:UsJ7lospEQcMj7ARSSXpcmxUGRzntKk/HmMoQk0aRCYM84MbyjlVfapcJ1aEcaUgGSryTIAwfuCLFNTMtXJEj511OpZcURJcgRIH8RGFPNKrmtzHsc5aRGWshZL67mtdcPrNl716HBHKnBm1jYfqsSUloPH0oD1sxz4ZBpfFCtaPgUSx0+NfIJWkwKL3pD+mN5aIS/WuAjaFRwwbT2v5VrLcOJOvmfwe8by1dRCM6Blo2Qmcef+CzuJJLSFDG5/u27++/3gLyJRJ2wUca/3A9wDF65+oYD0I0572HBNbov0LljAVQnHdXWyr0mPj6uRikzq3cQJOYGIdP0TN6fhj3RR7PbrpCrELTFsOPjBdZLk=;5:QoEguwBs/jx31P2zMlORxa1R4HJsdFztwPsrN6hFVUZf2rYxiE6dsdmXeklONlpboqohTfMmS8SDzZdoDrNrgmzMCsxU1rLJPVcyun4+fweWxEOxgTleKpC7BBrUR2Vil5+3awIKofSg+rmFkWAV8LYkaiUyNn+Q02yexX/ltZo=;24:uMsDG8TYVy5lLknWVRmYqYU1eItPkcabldIKHNQoGkWYuCZ8KufvzaGhrP3uZ5WbNjrlpwG4WIDRUbRSk26/7+/oFqR7MsoNpl3Zq5oUdUI=;7:+iHxrA91gnKlcuDb2YZN3/u3b/dfKDWzgTk1LG2UwtjikghG3Ed4cqrCeeqlULBwnDd2zOa6JM0Ka+TubPkaGKOm6n0hABkFPgQxaVMCABugjh/IguO38KK+gwMKrKp+YpzaHb0m1fP6g4QjuerKgcuV//KrxU7qoXucnqL/yQ7xUj/U8RXDMSyre4lFGSsyQBD00ViEQm6ScnZFW/r6GkSUgXyKWWl0OXl7/a3nYowoaX1SNUKvGGHgu1EecQdK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 14:02:17.3490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3aa167-f80b-4ed7-5b34-08d5836adf97
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR07MB2497
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 02:12:29PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 2, 2018 at 3:37 PM, Jan Glauber <jglauber@cavium.com> wrote:
> > ThunderX1 dual socket has 96 CPUs and ThunderX2 has 224 CPUs.
> 
> Are you sure about those numbers? From my counting, I would have expected
> twice that number in both cases: 48 cores, 2 chips and 2x SMT for ThunderX
> vs 52 Cores, 2 chips and 4x SMT for ThunderX2.

That's what I have on those machines. I counted SMT as normal CPUs as it
doesn't make a difference for the config. I've not seen SMT on ThunderX.

The ThunderX2 number of 224 is already with 4x SMT (and 2 chips) but
there may be other versions planned that I'm not aware of.

> > Therefore raise the default number of CPUs from 64 to 256
> > by adding an arm64 specific option to override the generic default.
> 
> Regardless of what the correct numbers for your chips are, I'd like
> to hear some other opinions on how high we should raise that default
> limit, both in arch/arm64/Kconfig and in the defconfig file.
> 
> As I remember it, there is a noticeable cost for taking the limit beyond
> BITS_PER_LONG, both in terms of memory consumption and also
> runtime performance (copying and comparing CPU masks).

OK, that explains the default. My unverified assumption is that
increasing the CPU masks wont be a noticable performance hit.

Also, I don't think that anyone who wants performance will use
defconfig. All server distributions would bump up the NR_CPUS anyway
and really small systems will probably need to tune the config
anyway.

For me defconfig should produce a usable system, not with every last
driver configured but with all the basics like CPUs, networking, etc.
fully present.

> I'm sure someone will keep coming up with even larger configurations
> in the future, so we should try to decide how far we can take the
> defaults for the moment without impacting users of the smallest
> systems. Alternatively, you could add some measurements that
> show how much memory and CPU time is used up on a typical
> configuration for a small system (4 cores, no SMT, 512 MB RAM).
> If that's low enough, we could just do it anyway.

OK, I'll take a look.

--Jan
