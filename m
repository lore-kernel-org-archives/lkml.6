Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752496AbeDSNpj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:45:39 -0400
Received: from bert.emutex.com ([91.103.1.109]:53634 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752085AbeDSNph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:45:37 -0400
From: Javier Arteaga <javier@emutex.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dan O'Donovan" <dan@emutex.com>, Javier Arteaga <javier@emutex.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ACPI match adc128s052 to ADC on UP Squared
Date: Thu, 19 Apr 2018 14:20:34 +0100
Message-Id: <20180419132036.27493-1-javier@emutex.com>
X-Mailer: git-send-email 2.17.0
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hi all, On AAEON's UP Squared board, there is an ADC124S101
    enumerated via ACPI. This patchset enables ACPI matching by compatible string
    and by AAEON's allocated HID. Dan O'Donovan (1): iio: adc128s052: allow driver
    to be matched using ACPI [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On AAEON's UP Squared board, there is an ADC124S101 enumerated via ACPI.
This patchset enables ACPI matching by compatible string and by AAEON's
allocated HID.

Dan O'Donovan (1):
  iio: adc128s052: allow driver to be matched using ACPI

Nicola Lunghi (1):
  iio: adc128s052: add ACPI _HID AANT1280

 drivers/iio/adc/ti-adc128s052.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

-- 
2.17.0
