Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeCOJak (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:30:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34919 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeCOJai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:30:38 -0400
X-Google-Smtp-Source: AG47ELtr+i+wZSxv81EPCWQlni4VRZE5FJacS2BYWTysf+rcQcjagy1hvKbaPqG3iURVJlRKnMITYg==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To: mchehab@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        hans.verkuil@cisco.com
Cc: linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 0/2] cec: stm32: add wakeup support
Date: Thu, 15 Mar 2018 10:29:47 +0100
Message-Id: <20180315092949.9895-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CEC hardware block is enable to resume the system if a command is received
on data lane.
Prior to implement suspend/resume functions a patch simplify clock management
int the driver by introducting pm_runtime{suspend/resume} functions.

Benjamin Gaignard (2):
  cec: stm32: simplify clock management
  cec: stm32: add suspend/resume functions

 drivers/media/platform/stm32/stm32-cec.c | 112 ++++++++++++++++++++++---------
 1 file changed, 82 insertions(+), 30 deletions(-)

-- 
2.15.0
