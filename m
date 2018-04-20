Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDTXY5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 19:24:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47638 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbeDTXY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 19:24:56 -0400
To: Colin King <colin.king@canonical.com>
Cc: Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] isci: Fix infinite loop in while loop
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180420095716.2143-1-colin.king@canonical.com>
Date: Fri, 20 Apr 2018 19:24:47 -0400
In-Reply-To: <20180420095716.2143-1-colin.king@canonical.com> (Colin King's
        message of "Fri, 20 Apr 2018 10:57:16 +0100")
Message-ID: <yq1a7txh35s.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8869 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=280
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804200233
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> In the case when the phy_mask is bitwise anded with the phy_index bit
> is zero the continue statement currently jumps to the next iteration
> of the while loop and phy_index is never actually incremented,
> potentially causing an infinite loop if phy_index is less than
> SCI_MAX_PHS. Fix this by turning the while loop into a for loop.

Applied to 4.17/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
