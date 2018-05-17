Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbeEQP16 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:27:58 -0400
Received: from mail-bl2nam02on0053.outbound.protection.outlook.com ([104.47.38.53]:56288
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751468AbeEQP14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:27:56 -0400
From: "Koo, Anthony" <Anthony.Koo@amd.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>
CC: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: linux-next: Signed-off-by missing for commits in the drm tree
Thread-Topic: linux-next: Signed-off-by missing for commits in the drm tree
Thread-Index: AQHT7KMZsfsWm8oMg0WTCe7+wJmjQaQ0DZhQ
Date: Thu, 17 May 2018 15:27:52 +0000
Message-ID: <SN1PR12MB25926F0C242C5EA1EC28957AF3910@SN1PR12MB2592.namprd12.prod.outlook.com>
References: <20180516091848.22a6988b@canb.auug.org.au>
In-Reply-To: <20180516091848.22a6988b@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anthony.Koo@amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0543;7:6/ETLdJbVqu7KuXyE2kw1AKuVVHXb7U+AVrqB1nchkXXrGfynQybdi/rR4foqpx+EJ7OWsYGsFMd2lBVmf+Hu9Nh+ZdKY3Orhr8Idv9RY4FlJryM0K5eziFAnK9JuBRH/ZbsKBjoJKuEBw2viMmEx8t7XwtyilzeC4eUw+qazVdic2dtNG3eV6ERWpakyE9HIYOxb9pwYcaS15Sxr8TeRAOBET7wt/WyCjN+TGtzLzc5fI0S5n+ZSVR4B1LH6ffy;20:2w8QMrfmm13Y/HVELm4ssDmNc/DxU9SgxfU8mvoylKdxU/FL1ArSNqGh18/Fu0tINMj6k+9k3gXebsfTdIjd2GLz5u/XAJVBMlQBk6cKibsP0r/cAfoqZpijH57G4LXpBBKobtnovhflliQCmdkhNdm1b4BuelK84lhvjr1XcXwy6DysdNeiBXEwqv+Jot7SXZVgMGFk/Nbhtd1KUpys3JvflphDtBSqeIVK0o1rkZgYhizPHlkRkYCbVCs1DLs0
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(13464003)(189003)(199004)(53754006)(26005)(7736002)(53546011)(3280700002)(76176011)(7696005)(106356001)(8676002)(68736007)(2906002)(66066001)(305945005)(575784001)(102836004)(105586002)(53936002)(186003)(9686003)(3660700001)(55016002)(4326008)(6506007)(86362001)(74316002)(5250100002)(6246003)(3846002)(229853002)(6116002)(110136005)(54906003)(25786009)(97736004)(11346002)(6436002)(486006)(33656002)(8936002)(81156014)(81166006)(316002)(72206003)(14454004)(2900100001)(476003)(446003)(478600001)(5660300001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0543;H:SN1PR12MB2592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0543;
x-ms-traffictypediagnostic: SN1PR12MB0543:
x-microsoft-antispam-prvs: <SN1PR12MB0543F57A4D45537DDE66B63EF3910@SN1PR12MB0543.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(217544274631240);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB0543;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0543;
x-forefront-prvs: 067553F396
x-microsoft-antispam-message-info: Hgth1hKgxfEdLmHUN3RUq1zY6Ss0mgd4mi8ilsZGb2j4h9icXtxt/d6b44HZN89dOJaTMl7aremkGNjIPIy77PrWuco7Yd+q8PG1Md8vcUsXUAPy3glrRkLpUDlYFpQS/LHDDkJh7oFz3tjnUY8HiikNaAJdbhkTaiKaWEMRXK5mchc8mbuqL9So9kkIFwe/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d86028d9-9019-4d0f-a4e3-08d5bc0ac199
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86028d9-9019-4d0f-a4e3-08d5bc0ac199
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2018 15:27:52.5778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0543
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4HFS59t019012

Hi Stephen,

Changes are Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>

Thanks,
Anthony

-----Original Message-----
From: Stephen Rothwell [mailto:sfr@canb.auug.org.au] 
Sent: Tuesday, May 15, 2018 7:19 PM
To: Dave Airlie <airlied@linux.ie>; DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Koo, Anthony <Anthony.Koo@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: linux-next: Signed-off-by missing for commits in the drm tree

Hi all,

Commits

  f412e8307d0a ("drm/amd/display: Couple bug fixes in stats module")
  e09b6473c605 ("drm/amd/display: Rename encoder_info_packet to dc_info_packet")
  87943159f409 ("drm/amd/display: Only program MSA_TIMING_PARAM if it changed")

are missing a Signed-off-by from their author.

-- 
Cheers,
Stephen Rothwell
