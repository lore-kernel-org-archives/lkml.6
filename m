Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbeERPZB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:25:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38128 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbeERPY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:24:57 -0400
To: Michael Kelley <mhkelley58@gmail.com>
Cc: kys@microsoft.com, sthemmin@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, jejb@linux.vnet.ibm.com,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH 1/1] scsi: storvsc: Avoid allocating memory for temp cpumasks
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1526591260-27162-1-git-send-email-mikelley@microsoft.com>
Date: Fri, 18 May 2018 11:24:41 -0400
In-Reply-To: <1526591260-27162-1-git-send-email-mikelley@microsoft.com>
        (Michael Kelley's message of "Thu, 17 May 2018 14:07:40 -0700")
Message-ID: <yq17eo1gf5y.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8897 signatures=668699
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=497
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805180168
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Michael,

> Current code allocates 240 Kbytes (in typical configs) for each
> synthetic SCSI controller to use as temp cpumask variables.  Recode to
> avoid needing the temp cpumask variables and remove the memory
> allocation.

Applied to 4.18/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
