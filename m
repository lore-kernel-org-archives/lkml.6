Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E616C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1992620878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfAKWJy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:09:54 -0500
Received: from mx0b-00176a03.pphosted.com ([67.231.157.48]:58760 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbfAKWJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:09:53 -0500
X-Greylist: delayed 6108 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2019 17:09:53 EST
Received: from pps.filterd (m0048205.ppops.net [127.0.0.1])
        by m0048205.ppops.net-00176a03. (8.16.0.22/8.16.0.22) with SMTP id x0BKOZYq039770;
        Fri, 11 Jan 2019 15:28:03 -0500
From:   "Safford, David (GE Global Research)" <david.safford@ge.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5] Extend TPM PPI interface to support revision 1.3
Thread-Topic: [PATCH 0/5] Extend TPM PPI interface to support revision 1.3
Thread-Index: AQHUqGg8qCxFiw8eqEqkK4aYmPL2cqWqhNVg
Date:   Fri, 11 Jan 2019 20:28:00 +0000
Message-ID: <BCA04D5D9A3B764C9B7405BBA4D4A3C0151A3125@ALPMBAPA12.e2k.ad.ge.com>
References: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcMjEyNDczOTUwXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNWM3ODk2OGUtMTVkZi0xMWU5LTgxZWMtNWNlMGM1OGE4NGIzXGFtZS10ZXN0XDVjNzg5NjhmLTE1ZGYtMTFlOS04MWVjLTVjZTBjNThhODRiM2JvZHkudHh0IiBzej0iMTgyOCIgdD0iMTMxOTE3MTIwNzg3MDAzOTc5IiBoPSJoaG0raXhHUUtlVDkzYnV0eFo2aU1INjBCb009IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-originating-ip: [3.159.16.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901110162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-integrity-owner@vger.kernel.org <linux-integrity-
> owner@vger.kernel.org> On Behalf Of Stefan Berger
> Sent: Wednesday, January 09, 2019 5:11 PM
> To: linux-integrity@vger.kernel.org; jarkko.sakkinen@linux.intel.com
> Cc: linux-security-module@vger.kernel.org; linux-kernel@vger.kernel.org;
> Stefan Berger <stefanb@linux.vnet.ibm.com>
> Subject: EXT: [PATCH 0/5] Extend TPM PPI interface to support revision 1.3
> 
> This series of patches extends the TPM subsystem's PPI support to support
> TPM PPI revision 1.3 where more commands are supported (up to 101) and
> the TPM 2 command code '23' takes an additional parameter.
> 
> For the command code '23' see this document here on document page 39:
> https://trustedcomputinggroup.org/wp-content/uploads/Physical-
> Presence-Interface_1-30_0-52.pdf
> 
>    Stefan

You might mention that this is an important feature, as on at least some
systems, ppi function 23 is the only way to enable/disable PCR banks.

I have tested this patch set on my HP Spectre laptop, and I am finally
able to turn the sha-1 bank on and off. Much appreciated!

Tested-by: David Safford <david.safford@ge.com>

> 
> Stefan Berger (5):
>   tpm: ppi: pass function revision ID to tpm_eval_dsm()
>   tpm: ppi: rename TPM_PPI_REVISION_ID to TPM_PPI_REVISION_1
>   tpm: ppi: Display up to 101 operations as define for version 1.3
>   tpm: ppi: Possibly show command parameter if TPM PPI 1.3 is used
>   tpm: ppi: Enable submission of optional command parameter for PPI 1.3
> 
>  drivers/char/tpm/tpm_ppi.c | 78 ++++++++++++++++++++++++++++--------
> --
>  1 file changed, 58 insertions(+), 20 deletions(-)
> 
> --
> 2.17.1

