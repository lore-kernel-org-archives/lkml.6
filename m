Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeERPZa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:25:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45190 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbeERPZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:25:26 -0400
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andy Gross <andy.gross@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-scsi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v3 0/3] Fix UFS and devfreq interaction
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180518062638.31777-1-bjorn.andersson@linaro.org>
Date: Fri, 18 May 2018 11:25:12 -0400
In-Reply-To: <20180518062638.31777-1-bjorn.andersson@linaro.org> (Bjorn
        Andersson's message of "Thu, 17 May 2018 23:26:35 -0700")
Message-ID: <yq136ypgf53.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8897 signatures=668699
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=513
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805180168
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bjorn,

> With the introduction of f1d981eaecf8 ("PM / devfreq: Use the
> available min/max frequency") the UFS host controller driver (UFSHCD)
> stopped probing for platforms that supports frequency scaling,
> e.g. all modern Qualcomm platforms.

Applied to 4.18/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
