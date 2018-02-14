Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935353AbeBNUbE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:31:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48338 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754735AbeBNUa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:30:59 -0500
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] SCSI fixes for 4.16-rc1
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1518639578.3223.44.camel@HansenPartnership.com>
Date: Wed, 14 Feb 2018 15:30:51 -0500
In-Reply-To: <1518639578.3223.44.camel@HansenPartnership.com> (James
        Bottomley's message of "Wed, 14 Feb 2018 12:19:38 -0800")
Message-ID: <yq1k1vfmhz8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8805 signatures=668671
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=296
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802140239
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1EKV7J5007660


James,

> These are mostly fixes for problems with merge window code.  In
> addition we have one doc update (alua) and two dead code removals
> (aiclib and octogon) a spurious assignment removal (csiostor) and a
> performance improvement for storvsc involving better interrupt
> spreading and increasing the command per lun handling.

Looks like your tree is out of sync with mine. I dropped one of the
storvsc commits that broke build on non-SMP due to a missing macro.

-- 
Martin K. Petersen	Oracle Linux Engineering
