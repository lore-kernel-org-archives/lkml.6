Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbeCNT4s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:56:48 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:59167 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeCNT4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:56:45 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 14 Mar 2018 20:56:43 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] remoteproc: imx_rproc: Improve 'imx_rproc_probe()'
Date: Wed, 14 Mar 2018 20:56:36 +0100
Message-Id: <cover.1521057013.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 fixes a bug.
Patches 2 and 3 are just clean-ups.

Christophe JAILLET (3):
  remoteproc: imx_rproc: Fix an error handling path in
    'imx_rproc_probe()'
  remoteproc: imx_rproc: Re-use existing error handling path in
    'imx_rproc_probe()'
  remoteproc: imx_rproc: Slightly simplify code in 'imx_rproc_probe()'

 drivers/remoteproc/imx_rproc.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

-- 
2.14.1
