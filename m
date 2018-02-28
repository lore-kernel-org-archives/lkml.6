Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeB1CYG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 21:24:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36644 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbeB1CYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 21:24:03 -0500
To: Can Guo <cang@codeaurora.org>
Cc: subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Gilad Broner <gbroner@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Sujit Reddy Thumma <sthumma@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] scsi: ufs-qcom: add number of lanes for Tx and Rx links
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180227055500.10416-1-cang@codeaurora.org>
Date: Tue, 27 Feb 2018 21:23:44 -0500
In-Reply-To: <20180227055500.10416-1-cang@codeaurora.org> (Can Guo's message
        of "Tue, 27 Feb 2018 13:46:17 +0800")
Message-ID: <yq1sh9l4ztb.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8817 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=695
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Can,

> Different platforms may have different number of lanes for the UFS
> Tx/Rx links. Add parameter to device tree specifying how many lanes
> should be configured for the UFS Tx/Rx links. And don't print err
> message for clocks that are optional, this leads to unnecessary
> confusion about failure.

Does not apply to 4.17/scsi-queue. Please rebase and repost.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
