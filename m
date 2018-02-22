Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932585AbeBVNVt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:21:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753750AbeBVNVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:21:46 -0500
Content-Type: text/plain;
        charset=utf-8
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
Date: Thu, 22 Feb 2018 08:21:45 -0500 (EST)
Subject: FLR on AER
Message-Id: <75DE2522-5DDC-4852-BE38-F7EB53691196@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
To: helgaas@kernel.org
Thread-Topic: FLR on AER
Thread-Index: oEqX/4cWIbXgD32elCwamZkY8TLhpg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1MDLsfi024553

Hi Bjorn,

It looks like the AER driver won’t do a device FLR but instead will default to progressively bigger hammers. Am I missing something?

Jon.

-- 
Computer Architect | Sent from my 64-bit #ARM Powered phone
