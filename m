Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeEROxM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:53:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58348 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeEROxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:53:08 -0400
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        vivek.gautam@codeaurora.org, subhashj@codeaurora.org,
        vinholikatti@gmail.com, olof@lixom.net
Subject: Re: [PATCH 0/4] Add required changes to ufshcd to support exynos ufs hci
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <CGME20180506102636epcas2p3432b71e5c867f6cfec16cf2a8c74b0e2@epcas2p3.samsung.com>
        <1525601658-31989-1-git-send-email-alim.akhtar@samsung.com>
Date: Fri, 18 May 2018 10:52:52 -0400
In-Reply-To: <1525601658-31989-1-git-send-email-alim.akhtar@samsung.com> (Alim
        Akhtar's message of "Sun, 06 May 2018 15:44:14 +0530")
Message-ID: <yq1po1tggmz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8897 signatures=668699
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=613
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805180163
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alim,

> These patches are part of a larger patch series [1] which attempts
> upstreaming EXYNOS UFS driver support. There was not much activities
> after v5 of that series. In between I saw there were other teams in
> Samsung tried upstreaming the same, but that has not really gone
> anywhere.  I have taken this task again and here is another attempt to
> upstream exynos-ufs driver support. I have divided the patches into
> two series, one which adds required infra in the ufshcd core needed by
> exynos-ufs driver and other part will have actual exynos-ufs
> driver. Splitting this has a advantage of less reviewing over head.

Applied to 4.18/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
