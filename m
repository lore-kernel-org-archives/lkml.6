Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933185AbeEHXFG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 19:05:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43906 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932316AbeEHXFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 19:05:04 -0400
From: Thomas Tai <thomas.tai@oracle.com>
To: bhelgaas@google.com, rostedt@goodmis.org, thomas.tai@oracle.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mr.nuke.me@gmail.com
Subject: [PATCH V3 0/1] PCI/AER: add pcie TLP header information in the tracepoint
Date: Tue,  8 May 2018 19:04:55 -0400
Message-Id: <1525820696-31967-1-git-send-email-thomas.tai@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8887 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=713
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080212
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn and Steven,
Would you kindly review the patch for me? following are the
changes details. Please feel free to comment.

Change log since last version:
V3:
1. use u8 for boolean variable
2. check tlp_header_valid before accessing tlp_header
3. replace sizeof(unsigned int) with 4
4. change the variable name buf to tlp_header for better reading
5. avoid extra dereference

Thank you,
Thomas
