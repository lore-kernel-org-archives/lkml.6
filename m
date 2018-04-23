Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932587AbeDWVi2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:38:28 -0400
Received: from bert.emutex.com ([91.103.1.109]:54285 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932401AbeDWViZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:38:25 -0400
From: Javier Arteaga <javier@emutex.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Arteaga <javier@emutex.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dan O'Donovan" <dan@emutex.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] iio: adc128s052: add matching options
Date: Mon, 23 Apr 2018 22:38:02 +0100
Message-Id: <20180423213805.12591-1-javier@emutex.com>
X-Mailer: git-send-email 2.17.0
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hi all, On some SKUs of AAEON's UP Squared board, there is
    an ADC124S101 enumerated via ACPI. This is a pin-compatible variant of ADC124S021,
    which is already supported by the adc128s052 driver. This patchset adds missing
    DT compatible strings for ADC124S021 (and ADC122S021) variants, adds AAEON's
    allocated ACPI HID, and allows ACPI _DSD based matching. [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On some SKUs of AAEON's UP Squared board, there is an ADC124S101
enumerated via ACPI. This is a pin-compatible variant of ADC124S021,
which is already supported by the adc128s052 driver.

This patchset adds missing DT compatible strings for ADC124S021 (and
ADC122S021) variants, adds AAEON's allocated ACPI HID, and allows ACPI
_DSD based matching.

v1 was posted at:
https://lkml.kernel.org/r/20180419132036.27493-1-javier@emutex.com

Changes from v1:
* Improved patch descriptions and series title
* Added an initial commit introducing new compatible strings
  (as per Jonathan's suggestion)
* Moved of_match_ptr removal last as this patch is less important to us

Dan O'Donovan (1):
  iio: adc128s052: reuse "compatible" for ACPI _DSD

Javier Arteaga (1):
  iio: adc128s052: Add pin-compatible IDs

Nicola Lunghi (1):
  iio: adc128s052: add ACPI _HID AANT1280

 drivers/iio/adc/ti-adc128s052.c | 43 ++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

-- 
2.17.0
