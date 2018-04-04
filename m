Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeDDPCi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:02:38 -0400
Received: from mail-bn3nam01on0113.outbound.protection.outlook.com ([104.47.33.113]:54816
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751251AbeDDPCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:02:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zi.yan@cs.rutgers.edu;
From: "Zi Yan" <zi.yan@cs.rutgers.edu>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Al Viro" <viro@zeniv.linux.org.uk>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH -mm] mm, gup: prevent pmd checking race in
 follow_pmd_mask()
Date: Wed, 04 Apr 2018 11:02:26 -0400
X-Mailer: MailMate (2.0BETAr6106)
Message-ID: <65E6BD75-FBA6-43AC-AC5A-B952DE409BC8@cs.rutgers.edu>
In-Reply-To: <20180404032257.11422-1-ying.huang@intel.com>
References: <20180404032257.11422-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_CB9590E2-828B-403D-9360-2645EC49EC8A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [128.6.36.193]
X-ClientProxiedBy: MWHPR1001CA0007.namprd10.prod.outlook.com
 (2603:10b6:301:2a::20) To DM5PR14MB1737.namprd14.prod.outlook.com
 (2603:10b6:3:133::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c889636-a953-437e-b9ec-08d59a3d1896
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR14MB1737;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR14MB1737;3:q4u5HMAfzEeg01ODx8kW0n0G8AFQHbZkihoTfep+TFIEKFilVq9l6UWXQhoD3qAwywpXqQk8kBesgAWp94EE+6Vnd8FYZ31M9MZAVp4UqZ/gKDE0ZH93Ag+pHxIdhZifbL4PbCEMWJBW7pK5pBWUcVuxZQ23Ym27Ill1roZzyTR/MdSOE1UOMPU88Ijeycd8Xee3f2J8ujfe0TvLLQbWL6fS3PfF35clKAoYauRNdZEx0x8lZURnBjFJNDuEJW9s;25:3E1x8MUHSA1niy2mt53PwzDMJPutC5Kiny+xTYII4OqwcUtM8tRvRD8nG3uyS3XeGQRzGKroPSuE2Q/ILE3rVzyQFlwleBK1SfjBy3fia8VP2HLLW1yd9S/wjDLWWC+7/LF+QRtpPCTsqcSIcBay9bRaEra0eBGTP5N0AogjdEJm4d+vBI/wa8TnAQAZPbdXj+GClS2CGi1FsodFYiVCymeFeUBY2voyeORnuu2iMp5cTd5AxPYbw1maFT5EQNOBbr4tgxMh3jWWE8Gxsy03kuBjn0GiXTRWS9K3mL40txMOUl45KC7Mgyxk+Zh84w+KdbqbKLuCaZS9PTpnQ+tNyw==;31:7oNiGsl+WqhTlb5r7T1tsev0jnsZV3IPM3XlIOQSk7K8qRPViNHhmEqMDLRzy1JS68r9rKIXMVLCE3NcKOgxEqi4Ev/VcmQV6gF0u87vmrb8HnbdIDDvpwJVU1Pcy08rM+w4paAJlECS7Hgd2Y13yjXLUP36R2yNsC3P7wWgVwDI5/ld/Y9YKMpEyWkiCWJVzpqZg5hvEtRcmrLYyNAAZprVjPkUsv+VU/p6SfsP9Rw=
X-MS-TrafficTypeDiagnostic: DM5PR14MB1737:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR14MB1737;20:QDJxHfs5L9vRpWEqsZH8uSNfgL9ZItvLlNclGbFjLDeLFZF7hmRSiqnf2uZ2SWUY8HQV2utneg0nZgMTMhdabSi331koHU4M+/7yo6akhRK72EfaVSqa7Q5s2n7iUav91fpjpWpV2reOnGd/FDd6s2/bvAzm+MNOXerXjZcqY/gidQifobn485hvQuZ3tGroHlhxKef8KQolFEiPzASrah28AmwGOw942JsRw2HfhxS4ZvsTL5a2o99td2fQFoE1P9WQ7SZpJfBIkiSSLygIqtRSLIIgEiIhTCqanlS4TxndFDtpRXdDsmVrH6sHctEJeZjNwI2LaP0sdzqgFqgM6bMcgIL9vHsjpDs3ZbRdTaEG+BQZGEH9VGXsGy+ePwCQ68CGdpEuNwHN7BEGqNW2UV3VCWzvhirKRWhefOGFRhIjm0suLQ5pRWsA3FvaAHaquD7/MgLp5eFA7owz1cNKxNVbh1O17N7Ek8xTNCnB6+NyYRGyMpa16qYioUnCQ7OP;4:SwjOUXVflCGiVxG7LGy6iDf9PQIc+engDezTs+Jdo8GENjuds6zdJSBwn26nDeiKjMFqa76OTlpQ4F7Dchvc8PRQk+4aS9J2BHGEJ5kbTkpFRJG48RvBVWt1T+swntuZGnB98IEeJfH1W82/K8O1xTnMYyw20Dz+wAHhna3W3twLFacOhfXno0oZ31IPSihMVfRaiKa7Mn0tihfD+zSRZj0fS7c6WJjBnusD0mReJRTlQpE9fnKAXpLod3UHfzk4WtyU/Cqmev7z9FlT26IEwRY3eC8CveYsXZCAO+UrYjAYIPNNH/Oxv1wC/hmE7gMJMTHr69Xi5F/vHfSeYGkQgixHJyrM4af9mBBR1OobfjrDkSwiYfTeLAQ9yJGxPVjF
X-Microsoft-Antispam-PRVS: <DM5PR14MB17371FB8D8E7AD91202C5282A5A40@DM5PR14MB1737.namprd14.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(228905959029699)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(11241501184)(944501327)(52105095)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR14MB1737;BCL:0;PCL:0;RULEID:;SRVR:DM5PR14MB1737;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(2616005)(186003)(66066001)(77096007)(59450400001)(76176011)(6116002)(53936002)(54906003)(386003)(53546011)(5660300001)(305945005)(7736002)(8676002)(88552002)(11346002)(50226002)(52116002)(486006)(16526019)(316002)(16586007)(16576012)(26005)(956004)(5890100001)(478600001)(81156014)(786003)(476003)(3846002)(82746002)(446003)(8936002)(81166006)(6246003)(25786009)(2906002)(229853002)(6666003)(86362001)(105586002)(84326002)(6486002)(33656002)(6916009)(83716003)(68736007)(106356001)(97736004)(75432002)(568964002)(4326008)(72826003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR14MB1737;H:[172.31.136.126];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR14MB1737;23:Rfu4i2uLBhURdjm3R37JFfjbJfu2O4976FotETiU+?=
 =?us-ascii?Q?xMEasqQGU47RCxWsqIoKLvvHvGYmPxkcJr0WYn8imRYRMSq5nNR5QL581FqO?=
 =?us-ascii?Q?IMNi3lvejcQE/MvbTDs5Dvn+T1InDHh1ay316Dhk9CkTkSPAdkZlVoo8MvbM?=
 =?us-ascii?Q?8wXWxxa++6yMX5vz3FsN669N9a2umG2KN+WgaY+wqUyY6S51ukqFhyNm5MzW?=
 =?us-ascii?Q?poHx70ledNtx2wWZXWT7mT6219f+rUchfFsPgibYI7wY6uXXrfhMEnTrYnBt?=
 =?us-ascii?Q?pjzqI/SPVl7oOEQ/XPyJE273Qbb/xXjfrR+BIxEWPPvpA3yT37wNZu58V6+b?=
 =?us-ascii?Q?efnVeM/ea2CvAgF700hsOtFNuZNHTYIjt7BQsO7xk2yvFjLFfvO3VMBakPFS?=
 =?us-ascii?Q?G242Wp5JK61SZMkK0Ll/w8i7UIxb031iFSPv3mWKcsuES2YyAGnBDsd9BFvl?=
 =?us-ascii?Q?BQnUtKXDW4tmJZrkQFUt6sKZDTKKvgAGy3Ob8nlufIwIrroaDh4M2klNgX1l?=
 =?us-ascii?Q?5NHS4VXOylceb47iOku56mboSyyykbGA35w6a2GiDlG7Y5JNu2wewGRw+tc5?=
 =?us-ascii?Q?Yz/dkmiUgaFyN570E7BAhkcwFOH8IaV8ESyeqx33mfsaDpDqJY69QObv5M/B?=
 =?us-ascii?Q?AolyyLUL1icAyk8EZMq6dHYSgJeJ6eQ9cJAiQk73tk5pN3Kqte6SfrBYu4T3?=
 =?us-ascii?Q?+Gypy0CDuzm44HnERIVCkbCAiKrz15NC+4F793c7T4vOGLcEc8Rpp8FyD8aX?=
 =?us-ascii?Q?MmmI/dSQLKPgYDwEd277spdLkzRrCW2wsujEnLCU5kcvFlOIiKao1Ps2R6XF?=
 =?us-ascii?Q?s+qZDUEKP7g0zTl5T05VwiqSA5WEkQA4Klkw8M1Fwtsxur/VmwZdJ7tRZll6?=
 =?us-ascii?Q?OOiqal87FC6OxHq3kXdVKbXj5/eeglaVRcd/CYrb2NgsPJDpbFSgbcJCDOaQ?=
 =?us-ascii?Q?eVCf2jhLXJZjK+Bo/96V70Nqr0K4edZsxVP0YWPZL8enbiF3sUTp72hV3NzA?=
 =?us-ascii?Q?ix4pKXFzkj/mnyfp43keBjUCIwGEWwOPWdLOz9FKWCa5hdFDwpMCsWeX7CAD?=
 =?us-ascii?Q?WQ+CTrJHaaTnT0/8mUrfxrZNbs8dYznJeEUM6Wz8YuEPr7XDruzukO/kUWpQ?=
 =?us-ascii?Q?QxK2eTfxcU6plsqfvG8JSZt8cvzZstE73jticDoYNrRCv2Z5+l3gJVm4ghLm?=
 =?us-ascii?Q?sUyrr7jByUpScgtFMZ7SWl1eQ/20V4vLq63PUGnSmUSuKN9LDpWV1S9pXvLS?=
 =?us-ascii?Q?krqj6n6g6XX7w3oi4YVGnbQMeZvtqOCUw8NFsUL7+NYxg155wBhOOfWNMWDk?=
 =?us-ascii?Q?THTpQk+jdIHx2OpH1jWe8y2ovDvLUdf9sAnfGoKRLZFJ/p1TvYHA2spLdY1Y?=
 =?us-ascii?Q?tr7enWdGTMX4YC+lh0Fuh/otFlO9atXPL3OiJQyydKQsAhz7eKBGcOTscCms?=
 =?us-ascii?Q?j1w8wehig=3D=3D?=
X-Microsoft-Antispam-Message-Info: nEIDVxEBIloBwE+kJwUPEsPp+LseVJvpfWi9qpOzIuKkmUO5tzFZKBvOStEzhfKnn97Zr2jnpzh30032r/DBh4xt1enZyb4tV+krFF5GgRtfbRfyeuCQKf7rPc9h4/04NcunZw6/G40jhznDQ/awqGPB0AzMZ5F77ZBb0fviOdIm4PnuJGsfm2wIqDnXJ1F7
X-Microsoft-Exchange-Diagnostics: 1;DM5PR14MB1737;6:88eYFAvAN2hcn5IjUx5yNqgE3CZgD/vr2c3hurDtZpvg5/DWgfeGk5AVUzrSLhJBHmUQzkDb+KLAxbR1pRWmT+Y2DYNRYxCJQjIMfBuyQjNtYueRTIRIh6Rlkt9/4Wo6bh4HRWE/D8WDVd7oHudhoXWG6ozUzKfiTD+9RD/UfSxjEFAtas4ffKfgTFwsIfSsp2EBUk5a/yoKQ7rtePLhYkDtrkxK3G77GV75o8C3unSeo/MKIVjQLFuyWJN7LeKxoRL04xBzEqOguaafIofNuJA3JnPvBqvjC5XdvuI6Exz6sdGdBbqJ9KW3n9iaNWeFVEAej/jPECETGYkR1GitPCuJ7/qBAEON8RPrhC8Lqk7NF9A1TZLV5WQ2ovVh/RaAyy34imsn+pmcAdfenXkNgCzmdRC1tlWcvPW054j0ANhDdtNLFeHsmCcMBH+pv/1xJhAGuovNLECgFK7bo4i/Aw==;5:cZOY/VixKxSyQcwZruiWMLMvVJ0QCODRqHfPGrMeKhRb2vhTsCykoGC2jCjF9gvR8b0Rnd7HZYXI3R30XOKPOfx9XxrbtBKyAgCXjAsUa+a33fB1TrfCnljNgzPCLZKRhn9WCzdCCztGIg0DGng9qM+W890mqdHJXP8zYBGCw7k=;24:XEDxOqnqdTKL17lN75wd5/Z74zX9Zq7V9CcuwztVvDV5QEtl22MTr6Ev/oM+i5YRf4bBNGeq+1psoGAE1mmjqPLfv6dfocyqwLYsNfYtOBM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR14MB1737;7:Z1r9Nnr48fD1LScY5XiVH3iLGB63COFTXbSblKeGppLa1UqnOk0cPAlHlciI3lPd9nirgRfAwe82qP6/0o+dogUSFqQWntxFAlG3QClrMhArbQwe5gPkprOwWgszJjInX6ZJBxxirG9NYm+7FiDqzdmrjmA1grBlO7/zmwEubCOPXsRB/EtKYHD4vPsFDgr/bgCH3aFdj2JtrkAvnAUJZs6hVjHZk4wbmbsSg5v9Hu0p5F8N9uxAZGAobDBvXbWy
X-OriginatorOrg: cs.rutgers.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 15:02:32.4631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c889636-a953-437e-b9ec-08d59a3d1896
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR14MB1737
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_CB9590E2-828B-403D-9360-2645EC49EC8A_=
Content-Type: text/plain

On 3 Apr 2018, at 23:22, Huang, Ying wrote:

> From: Huang Ying <ying.huang@intel.com>
>
> mmap_sem will be read locked when calling follow_pmd_mask().  But this
> cannot prevent PMD from being changed for all cases when PTL is
> unlocked, for example, from pmd_trans_huge() to pmd_none() via
> MADV_DONTNEED.  So it is possible for the pmd_present() check in
> follow_pmd_mask() encounter a none PMD.  This may cause incorrect
> VM_BUG_ON() or infinite loop.  Fixed this via reading PMD entry again
> but only once and checking the local variable and pmd_none() in the
> retry loop.
>
> As Kirill pointed out, with PTL unlocked, the *pmd may be changed
> under us, so read it directly again and again may incur weird bugs.
> So although using *pmd directly other than pmd_present() checking may
> be safe, it is still better to replace them to read *pmd once and
> check the local variable for multiple times.

I see you point there. The patch wants to provide a consistent value
for all race checks. Specifically, this patch is trying to avoid the inconsistent
reads of *pmd for if-statements, which causes problem when both if-condition reads *pmd and
the statements inside "if" reads *pmd again and two reads can give different values.
Am I right about this?

If yes, the problem can be solved by something like:

if (!pmd_present(tmpval = *pmd)) {
    check tmpval instead of *pmd;
}

Right?

I just wonder if we need some general code for all race checks.

Thanks.

--
Best Regards
Yan Zi

--=_MailMate_CB9590E2-828B-403D-9360-2645EC49EC8A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJaxOkCAAoJEEGLLxGcTqbMZU8H/1RA0Gu02wy0myF4tXGBkeFp
6TPYuRa1qbFQcyl6+2u3jU2gmKEWNN2JSHErUk97CZrgzuZ44tjcyf7VCtWff26c
lGGI2hBnNiln8w9A2rsZcxV/rKcNbyZftiXUoosR/WVhqOzlqIa+6zbXz426FwJs
9fCpogLVZrAJio/cCRHaBsuZxw7HD94wUARB9ofHHLuDPbcaQH/a8H4jp/Funa28
hT6ngohFqquFCCTVLkOSiNush8juSXXrS0QSqf35FWZKaW9QyvqLvx82CsXgveJ7
y/oSN7+fL+NGiyrqGdImkFG/AQsjcp5zfKfTh+MV4rSuMSGhbHH0WtRTnQaaCvk=
=DDkr
-----END PGP SIGNATURE-----

--=_MailMate_CB9590E2-828B-403D-9360-2645EC49EC8A_=--
