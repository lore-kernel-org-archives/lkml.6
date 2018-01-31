Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753003AbeAaC4j (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:56:39 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50444 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbeAaC4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:56:37 -0500
To: Corentin Labbe <clabbe@baylibre.com>
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: remove dead makefile about oktagon files
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1517229016-1859-1-git-send-email-clabbe@baylibre.com>
Date: Tue, 30 Jan 2018 21:56:32 -0500
In-Reply-To: <1517229016-1859-1-git-send-email-clabbe@baylibre.com> (Corentin
        Labbe's message of "Mon, 29 Jan 2018 12:30:16 +0000")
Message-ID: <yq1372mg2hr.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8790 signatures=668657
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=543
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801310034
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Corentin,

> Remove line using inexistant files which were removed in
> commit 642978beb483 ("[SCSI] remove m68k NCR53C9x based drivers")

Applied to 4.16/scsi-fixes, thank you.

-- 
Martin K. Petersen	Oracle Linux Engineering
