Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeCVBY1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 21:24:27 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44212 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeCVBYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 21:24:25 -0400
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Vinayak Holikatti <vinholikatti@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Szymon Mielczarek <szymonx.mielczarek@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Alex Lemberg <Alex.Lemberg@sandisk.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH V3 0/1] scsi: ufs: Add support for Auto-Hibernate Idle Timer
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1521551258-4027-1-git-send-email-adrian.hunter@intel.com>
Date: Wed, 21 Mar 2018 21:24:11 -0400
In-Reply-To: <1521551258-4027-1-git-send-email-adrian.hunter@intel.com>
        (Adrian Hunter's message of "Tue, 20 Mar 2018 15:07:37 +0200")
Message-ID: <yq1zi30q4w4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8839 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=727
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2M1P5Sk015244


Adrian,

> Here is V3, now re-based on top of patch "scsi: ufs: sysfs:reworking of the
> rpm_lvl and spm_lvl entries".
>
> Michał Potomski has previously sent a patch for Auto-Hibernate, but this
> patch is slightly different, based on the latest ufs-sysfs changes, it also
> takes care to restore auto-hibernate during resume, and otherwise avoids
> updating the register if the device is runtime suspended.  Also a default
> value of 150ms is set.

Applied to 4.17/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
