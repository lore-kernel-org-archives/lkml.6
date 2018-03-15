Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeCOGZh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 02:25:37 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:39874 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeCOGZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 02:25:35 -0400
X-Google-Smtp-Source: AG47ELskOyzbTlz3GtpigorZ60rknrIHRn/354/2dsQpfPzPtVyczlDANhXZNFUzhrN1cwg8b8MmFw==
Subject: [PATCH 0/4] scsi: arcmsr: Support Areca thunderbolt devices
 hot-plug
From: Ching Huang <ching2048@areca.com.tw>
To: martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@oracle.com, hch@infradead.org, colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Mar 2018 14:25:29 +0800
Message-ID: <1521095129.31371.25.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ching Huang <ching2048@areca.com.tw>

This patch series are against to mkp's 4.17/scsi-queue.

1. Rename ACB_F_BUS_HANG_ON to ACB_F_ADAPTER_REMOVED for adapter hot-plug
2. Handle adapter removed due to thunderbolt cable disconnection.
3. Sleep to avoid CPU stuck too long for waiting adapter ready
4. Change driver version to v1.40.00.05-20180309

---
