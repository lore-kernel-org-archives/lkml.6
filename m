Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeEGGnh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:43:37 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:39459 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeEGGna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:43:30 -0400
X-Google-Smtp-Source: AB8JxZpDIrXMZcGH82Kwe+pm1EJYZx8JhLh0PR1teMmJrAt247tCoTGQHDovqVdlR81YtFaWFl/ffQ==
Subject: [PATCH 0/3] scsi: arcmsr: Add driver parameter cmd_timeout for
 scsi command timeout setting
From: Ching Huang <ching2048@areca.com.tw>
To: martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@oracle.com, hch@infradead.org, colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 May 2018 14:43:21 +0800
Message-ID: <1525675401.8876.9.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From Ching Huang <ching2048@areca.com.tw>

This patch series are against to mkp's 4.18/scsi-queue.

1. Add driver parameter cmd_timeout, default value is ARCMSR_DEFAULT_TIMEOUT.
2. Add slave_configure callback function to set device command timeout value.
3. Update driver version to v1.40.00.06-20180504.

--
