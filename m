Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeDFS3X (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:29:23 -0400
Received: from mail-by2nam01on0084.outbound.protection.outlook.com ([104.47.34.84]:19477
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751276AbeDFS3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:29:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
Date: Fri, 6 Apr 2018 11:29:16 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: linux-kernel@vger.kernel.org
Cc: vadim.lomovtsev@cavium.com
Subject: [Question] patch posting process
Message-ID: <20180406182916.GA15772@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:3:93::29) To DM5PR07MB3002.namprd07.prod.outlook.com
 (2603:10b6:3:e3::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 022c18d5-b957-46f9-2362-08d59bec4ff1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3002;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;3:HGzA5YbFmbliTSJ/1Vr4MWfVvx9iVUgTcTKOhod8A6lfx5tmuA7CyljrFbqKOudaRLcVcXNaNI5I4dV+5PLSNP1dglwbDch4YsCYC3RWv/jANXen+WhLBIFXQPMkG3DmMrztxNUI5QNBhKTFGGBr6ihB0ZFVlZMNJ0+Np14JITQN2ww++qhrelKUQNm3IoJ0dh49ug06X8bvlWKLESttk5a0xMDNhsPZjmPTMxsS5l666LXusxyf3NVUe29feJKT;25:yWa729nJ0H7DpI7ndJAGznfjItM4Br/atzMC5j6ffT3n8wnvxbEA2zqAyVKVBi42VJn8vkE6KZs+QjcqXskhzFFxNwfYmtjHWwAtEwdX2jdEtPgixb3CsLLapF1jwrL9vT/pT0Laae55O9d8zCA1vxZCWBk40FIY1peBX7gHycKkGY+bmCnKo1bYg7AMuEjiVZjMFNK7RFg8uD0ly2Ee5MLAs1V6tY+PJ0r+WFR6fF13dbDLzXy80EKp3BICOw37tBHOX2FZjNHaFDX1r4LsMoW+5+v2mMJeO/ngvxbOGpAufi0vx+6tsTutlWNktlySFJymsp55CT1gkNwO/LKPMg==;31:R+5Zy+ov4xhN42caBS4mLsxO8bBN0+JJhvqlR+amCSsP77XJR39WQH3ugMmKdDWnv9P9O3CbrVfGAdEYCNVD+o8HuNPaDeYkvOjlwoOYL3pNWjxW9MnDmtCr7tP5uTAtj78AHoKLXAk0HMajD3eobwDRJYGvp9hm2+xiLeAvpm78GHKXYPZPHi8XUVA30DvO3DAbnrqBaZYAogsPLKr1B2qnOJgK5rFZoSBkaZWven0=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3002:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;20:0RWPg14GilSe8CRfyPo5dXCQtb5AKGDoBTT0JP9Vq49N18MWRJtp8/2ru2yIipl58HYg1aA22J6anqqb3uHLDmiLI7v1uwhPovYy/8kpH7BZOJCLVNQQmrYj++8d/+5endm6d50xnewJsXJAcYhwBLGQv1Pevb+Qwp2ptGwFAg4HUh4vga9XeEMTfIfW7MOwbs6QehbYVSsLkwhmkk635xmBrE5Sibr2BFngKxiq9WZyXbiSlRnzsynLiCEHo+5py2WnKNm5w6P9BlK4Yy9/dcsLhi1WUz4yC8Wafk55uHUvx2YxcvbBbu7I6GWu9o6baxZM0aOcgT6h44gAoCWNaHxOAfvEG3Ckn/3ym3/1gk3cpSOM2VUaKmmITke5QLGine3GaZkpp8SxDmcFmzx7g1IBXBjNojFeJ1ogmmo6cVnxYaTiWZW4xni4E7iZqqvuGJwyFZcE7513x1YkesUEu/5rkDT+QDBiiORlm59B1ZfRRM9a9DMT+ZmWAJ3LaicvMLnAB1v6Id7dYNtMbx0GIQxUjtvU74824MRVMJ3Yo4Q7kQJ94ItM0HC2aLvTR9JnneXtJyLtp91UFRuLRs3zR73uKlKAQ1GXNSGcAiiDYs8=;4:nzYe7H8+V/E4EzIms15fdmjQG3JovRPrHhc7JeGPCbBjhPrFILazSAt+C1buniy72mUXhdB97RJbHEM99bt9Kjn5gfbE3nkaViOJr32IMo/zO2pezlylGUaRTnY8U00LrTagdBUaLR/EiQT/z1NrY3YJFVDKWfJzHk/mwg1ExT1Xz72sOD2+0wct6066Gl/aTghSmJXuEd4K2A4dp2yc51HjLOpKn0fkaqJeCKIuC8jwYWNL7pIM73uNoasbXBHb1SinDF3ihi3YbHm71vnnLw==
X-Microsoft-Antispam-PRVS: <DM5PR07MB300296A75881247BF7E5BA338ABA0@DM5PR07MB3002.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR07MB3002;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3002;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(53754006)(189003)(199004)(956004)(50466002)(16526019)(26005)(186003)(2906002)(486006)(476003)(6916009)(23726003)(6116002)(3846002)(6666003)(9686003)(58126008)(55016002)(316002)(68736007)(25786009)(1857600001)(1076002)(42882007)(53936002)(5660300001)(16586007)(33656002)(8676002)(72206003)(61506002)(305945005)(107886003)(66066001)(6506007)(478600001)(2351001)(33896004)(4326008)(8936002)(97736004)(386003)(7736002)(106356001)(81166006)(105586002)(2361001)(81156014)(47776003)(7696005)(52116002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3002;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3002;23:8LyRios7tP1DbNZ4HMaFnlhetAjrNIkNiR/LDk8wm?=
 =?us-ascii?Q?E0bJtW+BKh/k/NUliiDCKIOu9h8ZJRI1/eoFtT+GwK6+Y49dRnsY3VdawOyO?=
 =?us-ascii?Q?XSTepGS0jUyRtSKwSs09cQs0pViVjvcDEBUaaa1c3Li/9Dk6HZmrHRA7aEm2?=
 =?us-ascii?Q?govIsk1LxxXtovLPs0TDlJ59ZMNZoq0rWjlNeBwy2FcoSr/HNV23v9PJwx3p?=
 =?us-ascii?Q?w8efrRNO9YlLvAagft8U9VLQfCEKDNgjNmgRy0ANH/zLV6TJlw4DvWwiHOKo?=
 =?us-ascii?Q?5/dxxonQsVLBFwDP/BK3bKhUOWrR6XKxdjzQB2h/0umuFnNLYQTz5dWLQxVq?=
 =?us-ascii?Q?9Bhqyc8TBbdmdgsgE+jGzjxl6uXy/6CMgpBl69T9ipaBWn03lVkCj00vBPM9?=
 =?us-ascii?Q?AfkPhEVBfRsFFlJOQHYYH/lIqJgZWn+UvlzR+wbSQinMqKOd/Tx+qVWMg4Wx?=
 =?us-ascii?Q?tM8dcKknzqQn3FVKjD92KfJQW9Lonj8rbBEbba+l7lRuWNfxOcC0+nJwPuSm?=
 =?us-ascii?Q?WOMy/NPDgLsU4achZiilIxEKR0iZ/+6AxH91POye0oo6EJg26ipsh2bDeGCZ?=
 =?us-ascii?Q?IU/c7/phrjFA7v/8cvFx+ogVi1gtSH0lUaCjAp0HpWD8cyJozNymO2LPWxjQ?=
 =?us-ascii?Q?cRiHESjtUHNYbJ2N6+ZfXQiMty9UhnEV5CCY7gzn4SA/GPSuQ9h/NeRXKtGE?=
 =?us-ascii?Q?CYDjdJlhzvutJYqdawE0Ar0EAaqjwJU/cQ5Z7NhAAKUZ0Gs24wAPEEPrOVer?=
 =?us-ascii?Q?hQcL3JTNTR7Dt/ylzgg0Vs3YSvhNTiTA1PZltEia0tvPyNs+B84oYXmjJaoO?=
 =?us-ascii?Q?IIzMV8V+1qEhtZNaLvBIQbGvszv5K1rhqPgEOM6xfcToRtoIZZKCXBLdarmB?=
 =?us-ascii?Q?GS3y5MRYOJF8nKFfmGlfySnAy4SCS9ssMzpGQwZeKiyUq+vU42xsVZCewVQr?=
 =?us-ascii?Q?j62AmtCTjivJHRwOCBeT80l4O86HZ1O863UnaG6AJwcnnDDbVVn0ROANglsO?=
 =?us-ascii?Q?aoGu8w6xS0Eww8NNrSWsXTRJTxuFYc7wzJ66iJ5yYA9v4lbak7IfPZHQ7y25?=
 =?us-ascii?Q?vFEnbK2dfgFf8Y0tLmhtI/47yXBhH1i1MkO0T4yLXUItNic2MxLLhr3SPXiA?=
 =?us-ascii?Q?9rcUzpJaRgIX3Kp9Mpl4lDYfnT/qwZrpc7igKAGs7F0WJ30BZ2z25FlBRBVX?=
 =?us-ascii?Q?z6rzcVeziBpFgsOCy8G2iLEwlrqe9NcN/96yv386RvSdCW0UFcLK3bZ1pB5L?=
 =?us-ascii?Q?D8PZ9IlaRQeNIELI/IA02hT9pADUMoAbp5+X8LzubNjDcveT2jPp7ag7u2HA?=
 =?us-ascii?Q?9I2DpF4I01quK+8Kg2r2QYULupL1cSKSIJAJk+3/USa?=
X-Microsoft-Antispam-Message-Info: 4KMIerGsonYEjdTaOAlVZeYLPF7AJTRIcLmokES7gp8WV5wMlD/1Ulg7aeHDvGbkn5lPrbL9/gZBq/zCEDZEscm2JPnHC6HOc/ALVyEW/VA/OHnn51kyy3q+HOh5t4FVuzlKho/3HBi0qggDoK0TRbABompLsTiRH7BzysEoVt9Kx1RoQgWhbGVwiDFFUNc6
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;6:Bi7aftK5Ci0jWD2EK7Z8TcsqUPvVnhiBi9N/zSHLrz9goXj4n/9tGpjOdU2kQjToDb9FKnWbTh87Eii4mhY8QADGeWggbFg886QmIBrvYgJu2QbdKeuG2Yfsp+q43lAtWzTZxc28/zJ1ixyRw4wG+wfBEbb4NYgn7TZgmcLBxu3a1LO2AeWi/e/fXsCaV/ioKlYEMpdfotlwepT8/q7d/WvavpWd58m2FiokZkZBgeE6bht3EapjLiMGBinRno/uPYn28hMWo/5uURmCDzH//aC2T+94Wz4r2HxSUxpCaM4TavN2ro1i6/pd3XC36Sj9lwZJ/OWKJqG4EHiZ0Xv4sXIMipyDVPJk1xrGm1wm/b2gJvrzifCxe6qJHPCZxUpDHloF+w5tfc1rrB9llttDaCBdDiOxHZ9C6pp67UREpjAA5hw5AyW6QjETkvp3xXv53sQSY8+1UlW/0vlLAXT9hA==;5:Bk9dOanHTMeQh5FYHHX8Xq25lg0wy+/eWfRns1RyLjdcPxfhLbniT/SvdvwkEkLJjlwDbUdBwewL85AUNKwh3UmsneycUs1/El+Z22FcMVITaQwZaruL8ORPkmQBSkut6rNBW3BiPKtdsr7P19olU3gbkdHrA8ENpEmZz12Tago=;24:lpVRpsg56Oe5vW/bNfdQTPpYO9aIvwq3gdXlBh7B2MXkxLDplCiw2el5Rl2jjw1z0yDiyiVR3VMgmvJA5fJdEoF4JI36wUMfBzdP/jnr3Ng=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;7:iLKyX5Il+9VYeuPFK2eLVAzI76qlTVSlFF0SA5cTO05dOG8dplSkJip729432AQX4or9yKSzFuhYxzkTnotT1V7oXiym3nGYkMdZz7hBM0oIllpBQr+0lOWbXTHL2kzvgEjY/hZijMvQoDD1EKzVtt49W0g1yq9wyIhSY2+mh8ffjNb4NvcCN2FHjUtewJmUVzB+cHKjy50pIl417nNQzSbxKfey8huxwwAc9ZzMcFUI31/KI/VDtrY1BKFDIJ6L
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 18:29:19.6239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 022c18d5-b957-46f9-2362-08d59bec4ff1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3002
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I bring my Apologise for wasting your time, but ..

May I ask for some clarification.. When we're speaking of 'posting patches shortly'
does it mean to send them in next few hours ?
Or would it be more acceptable to post one version per day
even for very small changes in between ?

Kernel posting guides says that one should wait for about a week for respond,
but in my case I've got feedback rather quickly (thanks a lot for that!)
and I'd assume that I can proceed with posting next version.

So, what is the proper approach here - should one wait day or two
before posting next version even if changes are very simple ?

WBR,
Vadim
