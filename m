Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965528AbeBMSdG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:33:06 -0500
Received: from mout.web.de ([212.227.17.12]:35847 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965365AbeBMSdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:33:04 -0500
To: linux1394-devel@lists.sourceforge.net,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] FireWire-nosy: Adjustments for three function
 implementations
Message-ID: <c4e817a2-1554-2480-9469-9d06543b1eee@users.sourceforge.net>
Date: Tue, 13 Feb 2018 19:32:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:RXWIFPxpYu1B6aMGmPXNMUjH2Noxxx3DkOno6nIe1H82/tbXGTO
 LZYAG7/t6dFN7SzncsQkoj0LjuSAyHU+tWihM0yOisrIsEeeLhEsBvOz8UsxGBK0IqOvV+D
 1dxkgRAJwzhdT0nDCoXx3upPD1l4C6A1lKTZpxhA1z9OdBOa3T6nrkO7RtCUzfrpamKqsXs
 ONvXIT6fqPSXmYb2Sgl8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Snb3Wl/vYgY=:jZLGvU7spah3jNAZn1/9L9
 9KhV5PzlwfqSNQ5Oi60aDw8LK+Ri7H5t6CJ7Pzs3XOLC/dZ52hTnf/GwSilqcnmSjATGOH5ri
 YPa92xO8cFzb3Ggpl4SwkXQiCm4dstB7rZNUPHDn2GA7y20ZOCdz6sUbyIufAgsYSrOZpNWTX
 zDFB0KjFcyqmFQhf5XHBLB2uxY/A+QyXy/GRSubkyip/+zyk+ta6RVwJoZxQ/6qnKTOx4rZd4
 VI6qr2onlnHqKDGNQMIP4JR9YZxhtzcBNqi2W+WKwEkiVuyBTOuZ0KKQN609XcaAyLUhhhQcm
 PYkRgLz8qzeCCtCuxej8/aT/CZQmWM8cntvN9JAtaw2ZBdW1pz8gLSMdnsQ9r1EFzTpeWv65M
 H1UyVGTGPwITtOith+PTNlxTuzy1TcMGNtT0UbRaPKiNHVe8W1mn/SabmjyUrKLDd35/SNR6v
 4r2X3mnOtFftK41gauD4RCDtitVTRFLJXveF3crZJ5OHkq96cCvLiLcmvh4l9w6uBtW0Nl2di
 NIqXDoW2/5jN9PsHXkQ25hnOpZ5aKd8i54y7PXDaaylRHmOHudedYWV0MvK/wleWw4+qy50sJ
 esjAiMmNXZC1Xsl3En7VgAwrys9FHedzDEaq28nOA7oy93zzHxX06teFiXIAAUDW46gtJA/1G
 WDKweaurW/DsXiD+f9r3SaEAEFt7hWG+lNimLHbtYbRh6qvJKL7LIVDxKOQ8Of4NJ8KeBDG4a
 gROSQwT3bqJBr73YUi8tVqM9wh/VQGhpGX/laGgqK0fK+22JXqGKQPt2BEM2Ggpx3F+pSbNp5
 ybtPfnDwEAt56+3xNvPzICCKYI4d/GsJ1BOhpd9KOQ7nMTnhoY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Feb 2018 19:30:19 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in add_card()
  Adjust eight checks for null pointers

 drivers/firewire/nosy.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

-- 
2.16.1
