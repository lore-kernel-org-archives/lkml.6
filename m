Return-Path: <George.Cherian@cavium.com>
X-Google-Smtp-Source: AB8JxZq+PjWnVZaknGEHg6cAdz+U6AG2U4iTgcU0Npjosh42E6Svmd7uJh4WY+6d47Mh0HJn8eYb
ARC-Seal: i=1; a=rsa-sha256; t=1526454038; cv=none;
        d=google.com; s=arc-20160816;
        b=d0y7HjA0Uk8v+qX2QE/9gBPogJeba3A+CQQR9mIVlN8E90Ii/Yc4+mb7+n/mVSx1v1
         hj0oSbW+N7/pWO3CTq3Wbx53hb3duWZPAjYeeEWHqvnHjG1EN9j4Ex/vgsA/s5PeAmju
         YSSd4dFmp3IJiESOc4QEuPKeyLG5TwlslRl2OF5ZpZzXrzhnaDegzD42tDde3w0mPvuN
         /4TDQg1U1nNB+mWjxWADnOym2de+6Uig2tOTnIzWKqiNIjU6IT95AecDFqRdBvSYn8VZ
         3FyNGckQ7iflhZ/DNAUMgDNobei5vIrYEdCGtZ6yeDjA2GTDQXQ8YXeqicsTxvly6pzz
         o5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=ILR/8DnWfWZucPCBq7HUq5/JCexnzKmvZ9vzLovL6SQ=;
        b=jZ1ByjB2R/22seuRtOoGnFbMuWyyMgZ0Fz69wJan1vUoJKlSgipDoDUDxu4PZlRBjg
         RmsaEdnCkU6zFjIaU33gkkg/kGGkT97zVNJci6/fuyujy1Bv1KTHBkUW7IAChMW5wq/e
         X0vxmhfFz8VGp+siCGsJcajcysgOYbE7UTeSN5tAHoAJa4iLPw1xlfk9zZ2vyvrMH4+D
         F34SkpnVERPUYLNhaLJMdk/vtB6pMlAjdEFFV1792NpoLS/8ImMvZWmbGdhB2Pk2sZMr
         BdKooL8txtd4MZ7ict7ibgCzuY6koTH+C+kF4LnHd3pcp4879bKVJWIGdW6pEqcyo3gK
         O/kw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@CAVIUMNETWORKS.onmicrosoft.com header.s=selector1-cavium-com header.b=i+h+5Scl;
       spf=pass (google.com: domain of george.cherian@cavium.com designates 104.47.38.61 as permitted sender) smtp.mailfrom=George.Cherian@cavium.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@CAVIUMNETWORKS.onmicrosoft.com header.s=selector1-cavium-com header.b=i+h+5Scl;
       spf=pass (google.com: domain of george.cherian@cavium.com designates 104.47.38.61 as permitted sender) smtp.mailfrom=George.Cherian@cavium.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
From: George Cherian <george.cherian@cavium.com>
To: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wsa@the-dreams.de,
	jglauber@cavium.com,
	kamlakant.patel@cavium.com,
	mchehab+samsung@kernel.org,
	davem@davemloft.net,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	linus.walleij@linaro.org,
	rdunlap@infradead.org,
	george.cherian@cavium.com
Subject: [PATCH 4/4] i2c: xlp9xx: Add MAINTAINERS entry
Date: Wed, 16 May 2018 00:00:19 -0700
Message-Id: <1526454019-32714-5-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
References: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46)
 To SN6PR07MB4926.namprd07.prod.outlook.com (2603:10b6:805:a5::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4926;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;3:g0BheZbbhnxPT+HB6QZ18AmcsvernwX/gStDwtXcLjH95Jq9sTMulEK2MnAbNShU8ydUPxShyUt0H0aLDXOrHojaWld0Ll18flYA9SIxghTwfviA5lbhL7Xf5gR2y/ej5eFe0dcXqyDpQL7reh7cNrMVuXgNXysTScmoeDWE6QHw60gyC44pwQC9T3wcB09aS7Rwx0H8gKNHLSDMqoCm4Nux3Avxj7cfwotcC+oRgVe2UK6PFrOEvFVLxlLec0lF;25:EMMv07OhcYIwb4AsiBpZwrwxrG1oWQzdb/vz7q/j5Aiu3wSty234jiktwqahSN7GiQeu1dn9GJ0DK0tf6hBRAbMxvV5yfnetHB9POXZXh1jhgijFhNenN7nHUsXMvt4FInNDvMCrowatghwIP4y01yjyXaVAgc9Dke1gqhR8V9vcW1Mvm7wUL1Wve96qGUXKB0mLfGJ90nAAWAm1hx0gGkT5gLYxEeKNck4RITrdaeo1Cdjm1M1WoiZX8EwzOA764ARBBT1S08zhJmwg1YxtbYfycOVK+ECgv0MwnW6095pK0MswY0YY4JtzsnhraZ9Hyc7AlPXqCm/FixY79RJlOA==;31:uuv9HkDkNGoKzheRjCSnrjD3lXtoRUt27DUS4uxvfaZR8rgRhCCKYKtrQThIooO8Dqb+YPEEq+trjXdQTk69oT5Zr88ev2AGDTC4tiP8GSy+v9mNEb60JJh0Pr9QN294HXSAE1w+aG/Q1dp3IfpErhdkl/W5h+tWz+6rII9B6HF9lf/DNcxMvKtXpzlPF/1+n9ATRt23OBGTj9WibACTXlBm7LmDtdK6WBHWFJ7MOsY=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4926:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;20:4bxBDrqGN/d85daK4aKZM6SQ4Yp5Qrsa7xg06apo/9mXnXQNi7S18gi6j2Yoc1t/GvEV7H2h/r1RsuzeJNvOGOTJPIjeFIhxsa6cAsugGaibvX+miKqgZCryLX/BTk7wz5y0RLZwzcHeOIwKKDqQPa8iF1UvZGDV9NDVWjXlQ1xK0E8PSI+JBRppT8pXTI1E6vefmIZcmaFy9wQmuC4QqwAAyM3FKLnfRxOO19EV6iSi4VP/m/n6VdlnQWgtHxbnXdZ/uOZtmq728AEetWoQWC4u7oS3KD7XGCsjziJtjOYaMh6q7GscWWsjwzpaadoDUC0N9hZsAwxObwqfR958nC4hwo8Cmgx6/bsvZFQg9MGKiwKEMeN467BueebYdc8QlhTf90B8RVAt9QIDTdbjo6dR0JNL5LLScd39CqFPqKc385tXm+0RcmWKkqemp6U/Vr3Vc9yWrsfqhYfGqghn9mUTMp+CybQOocAU/zfFWLb1n1jtsdbkBngh6E0TQJHL;4:6QhZ4C2wXoPFtd8L/Co3l/Q+sm9ij+ii7PtfOBZGNgxypC3T6HI7ekWDWEhwraZVjRHVcig9t3hL1ijpcWCQFJgzGN/DLNNWQPJiA1sSegPy7q+MlW//cBksoaxZWeB425wiCJa7ww2crA8SiD9RYSHwUDySkvmphlm10SroLWPZDR/Nl4CSkcRBREHXpXZf0y1uGHz5rcdSVNfIZzxYJJ6GeEs8WVcAJUoT4RzCqqnLN3wlfdLvUktAY63jZXq6TwzYDmaqa5149oP8aweZ225MZV1aoYnmRsFPMTtmbX4CUa9W9dzkHKaUnSSzOfyaWC4KZIEUNold907Ta9dvRFPSXAfeWr6LWqth6hYOMbI=
X-Microsoft-Antispam-PRVS: <SN6PR07MB4926CB0DA71F9397959E1186F9920@SN6PR07MB4926.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(106981052589767);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN6PR07MB4926;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4926;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(44832011)(50226002)(7736002)(50466002)(105586002)(486006)(53416004)(36756003)(8936002)(106356001)(5660300001)(186003)(48376002)(316002)(6486002)(25786009)(16526019)(16586007)(305945005)(966005)(4720700003)(68736007)(446003)(6666003)(72206003)(478600001)(476003)(2616005)(3846002)(6116002)(956004)(11346002)(97736004)(4326008)(52116002)(51416003)(76176011)(2906002)(26005)(66066001)(47776003)(6306002)(6512007)(81166006)(81156014)(53386004)(6506007)(386003)(69596002)(53936002)(86362001)(107886003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4926;H:sbr2s-28.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4926;23:dRxa7HUyvSedDkzPYgnxbrC7Gc7t/HjhmSMJFLzj4?=
 =?us-ascii?Q?ZQgpMhv9Q9oBlI3skE1+erNJUN6NLf9raPwpfZmoNzOjK5ssifV7oSwGAhpr?=
 =?us-ascii?Q?Edd7ZQ/VnoCk112dldI4KL03GIT45FJpHHtyKIxu1tlND5RPPXYHjIerL+e1?=
 =?us-ascii?Q?6DMtzaSUFyEe6D540wPOB5bGsUvlXEMH0HRQFFySb6Uai6LZPljB0Q2v7R7D?=
 =?us-ascii?Q?79NJPJ7xboUEaKGhcG6Gy73630bYCz6N9uxRPAfeS+Eu389B0/ySfAzaI5Sa?=
 =?us-ascii?Q?cNr5bKIrAPMcdpT8TjXWPik8Siyya5C6IqHc7YfYy00GE1dPJRS3Nyx+x7NG?=
 =?us-ascii?Q?viNG75VzASKYS9TFrcI3lKfvT/DHu90UlCwqnC8v1Btb8+ENBNtEnRrRQ704?=
 =?us-ascii?Q?uCjyoqdr7nORiBB6QfAt2P09D3s6WZfxPH4cSI709CgRPBkeXIEXyJWZMIkg?=
 =?us-ascii?Q?5mRW/rLSXWGDRJORYGMV9sqlo9CjX3Oee5lmRAe+yA7Y8p1bnfKTHKiD5j0M?=
 =?us-ascii?Q?mf8iyRwif6ygC4F2C+Tl327iodFacwbjHVZVrFF0IvEEFl0UgIfYH9XY85dN?=
 =?us-ascii?Q?hIg5MD+kg1blAjos9Nv1rU0iwE1PeYiQK/oJ6hAiVihDAKqLuoS0Bk7eyGBy?=
 =?us-ascii?Q?Z8NyrNJzk4cH834TblgiI4pNCkHsUqzj/7ZBtWwwDRAL2ZrjyXeBmlLRAAnR?=
 =?us-ascii?Q?JOE+2vjJ0enmsaV4DFFbFZIYMM0ovi8gIKh/BIvZDiMeMuvHfjeBLOf4l9aK?=
 =?us-ascii?Q?kDymEMNn5IawxyhaahMwSI94EDTvDKtmZ9HfIYfng81hU4wty0iCi2kTUD/q?=
 =?us-ascii?Q?/aU9rYUgQ6Rsa/P09tAms/or5fCIy1Wir4b4r+na7dsQxrFtDzd+VgArB+bP?=
 =?us-ascii?Q?qgHnVUfY4mQ0JOpGrYaFbTlY09FuZ4n+qG1IPN4oV0F0iM/kdFh0Jvcpktmn?=
 =?us-ascii?Q?CHHkxpyBN2QuZWY3AoWiNCeLj8LhJ1vOyrqXITm7QPU6KBEWE8a4ODX52wO/?=
 =?us-ascii?Q?lS5qZA00jwebXais06FLT7hSbXo/AI/aODkPXsw5I83/MSXdah8hXOU5qIDL?=
 =?us-ascii?Q?371OG0MBUg6yMIj55Yl00JTG2DwjYyjCQjml9thOYqzbCQp1CGt5BoSp9nwL?=
 =?us-ascii?Q?kQy8K9zpF0725Uh12FZfSMwVNPhdioA8jqF0QDG0cuKlPAd2gYjLyVIFSUCv?=
 =?us-ascii?Q?XZqgt89jpIbgNCQyJ7vSwzcbzyy+fWyfdl5d54wfTQFrvdYJxRkn+wrA2MCX?=
 =?us-ascii?Q?GQLvfQ2ZHqovgFmAGbvjwtarVg57QXRaKj6YJtjTpvcVtK3owZ88UBvaqhYw?=
 =?us-ascii?Q?HLxxtInuyNIABN6TS6ZjOmZ4GSp/5YXdz7T6MbUDLmQtWstMZrCSZYM8BJwH?=
 =?us-ascii?Q?03okg=3D=3D?=
X-Microsoft-Antispam-Message-Info: tRlgK20//kY//ubmD4SLC2rz7pH72XEzh9M6HqIp9vn5xkWMVyjM+porrU2No70IjJdPLtHmRHpktbTN3dtD9aYLizuDPiNSYvE94Gu9ZrETFl5I6TTp9Ec2psOI3oQMdSRFpcEt/XmwVHyruYtw3JUjhmr7Pa+1+/B5rVxsQWjIPk0GEcDeGf4/MIx4Yfwk
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;6:mBm1W4lfU4OO22Hawb9lcwsgvKSxdWejr+JyZ9Y4ClHYL7OUIfc8xTVyJilPGoZDKuhvP5Ql3huZ3GKeK0mrzybpv+TEI0yolwo5+4fOpdvfFSIT4q4lSOTOyhZe9/YJYAMnkh9u3GKCurEQhG8wKTaO0n/+aDlim/KSJXLChFshFv/6TTclLVJQg/WhGvHEj9jTZ0aUoWiXO6hYgyhunax4bviFh/cRmvTS0SyE4fu+/Aq3Cl7Dp032euTsPo7d6q3qydaDXgPUDCp+NLYwVHTtLk8yeDjrT3i4dIQOWatsitgpvCLToG0knM0yNqJzS9u0PgOXS//9EsOOVKdDMyvj089yj3JFJv+z1+SXNbCuSAOB+xO+87rcGiqUvmBMspSPzVdQVZu519bBz7Ch+kK0Y5wLroBZFs3V1FOuhjO28088IEeAHdkihqf+1mVQBUDwOksOR/GPb8shGGabVg==;5:MUn0qsPbGVx9G4F5PctKtGGeAfUd+owdKR+zXfVClGdgVx06BQd1y3smgw49Xppjb8aJHgXJ6IV8Qooc1LWRz/7Xzuga/O3FPywzXt27Vqh0DGbLKBZ3PIvcOgoj/W6bVXYpiadGAAwOX+Yn1Nn67TuQK9suo53UYOzh1hBcv6U=;24:RD0G1Q8sr62N6/gaMUDK4F9r3wOSlQPIMSx7J61+lBXGeFgAS04xYyDGNSP+orzBT89FKx77DrR3Pcub4i/dV+EuYqoAvri5AML4QagKyuw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;7:ELjLRklcJC9gGuTgflTHt2ABnr1eHKU93DuLMuDWOqdPVc/wVQBBBr5zpVZNX+2O4RmBw/Sf0RonUqKorQkQQzGMa7C9WvkaLN3VzRhgtSKfoN15oMND7nOnBrxT8QnVHUP2oLXXNqXJyXg7J8g0J8a3KeAB69ZTL/j0kT9/v9hlgCqRTyoMjXuXL1GFKy7gkqaWr89jgmSyB/20dSkj01Vz+jo99bV1r5bBGKL0NttgjmxvP2D7Gen0k3Dje6pe
X-MS-Office365-Filtering-Correlation-Id: 9b294a41-51df-4761-637c-08d5bafaba01
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 07:00:36.2953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b294a41-51df-4761-637c-08d5bafaba01
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4926
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600603069522924646?=
X-GMAIL-MSGID: =?utf-8?q?1600603069522924646?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The i2c XLP9xx driver is maintained by Cavium.
Add George Cherian and Jan Glauber as the Maintainers.

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index df6e9bb..68da265 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15509,6 +15509,14 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	drivers/char/xillybus/
 
+XLP9XX I2C DRIVER
+M:	George Cherian <george.cherian@cavium.com>
+M:	Jan Glauber <jglauber@cavium.com>
+L:	linux-i2c@vger.kernel.org
+W:	http://www.cavium.com
+S:	Supported
+F:	drivers/i2c/busses/i2c-xlp9xx.c
+
 XRA1403 GPIO EXPANDER
 M:	Nandor Han <nandor.han@ge.com>
 M:	Semi Malinen <semi.malinen@ge.com>
-- 
1.8.3.1
