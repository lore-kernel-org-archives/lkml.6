Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeBAQzM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:55:12 -0500
Received: from mout.web.de ([212.227.15.14]:50894 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751783AbeBAQzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:55:10 -0500
To: linux-i2c@vger.kernel.org, Till Harbaum <till@harbaum.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] i2c-tiny-usb: Adjustments for i2c_tiny_usb_probe()
Message-ID: <5ab52458-e334-bb06-8d7d-66b48ac3f30b@users.sourceforge.net>
Date: Thu, 1 Feb 2018 17:55:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:rxp0ANqcZF8QMcykVyGInadZ3prDswE3xwih0gVRe3/TRIRgMMS
 RnHGM7ajZQYMU1PsDIrV8UBIwEF2nuO4tq6Boo7x3bNoLLuWTirKqn6lRxlN4N4iavJxFUY
 KAyo/lyHqcQSbSmx9M0Lg0RpQXst2ABZyR3HFoK3jBvxo4mbDS+wn5mnjYXhGvg0o39QRfB
 1Lkwi/v8JLF+m1u3TB4OA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cV5QU8PYvs4=:WkBSceXqppG8xWUYS38bGG
 cvpIPHTkA+m7i83xlc1j+9k41Y55Hx4jKVod7SDBkST3aJurH3DMLdci/R6L5wQdOjBvR5hZs
 ky+Bl5krfFFvztMnGzZVlFNB61ms+65KxZ9B9tg10HbG5Sh3eqZFbrHiSfXrmM/Ib+6iR+0I2
 sELRRP3mUQJoBfjphb6LnFZGwMiwrE4/17NTFEL/u+l3pAE1NUgXAV3sqe7a4TiQvqwA6EM2a
 /GR/+RpwIOrCu/Xxcz1VvQ5/cb8HQQU4Yjv4A6dJspCcpZPFfiJp3XLh6CeBX37s0K0meWQDs
 nr8Nngx59f5a5ONUARlttsRqTPGNqH/ZxS/MkuyPIGtnWhY4fECu4Apvl4W3EnS/w4DDSqw3Y
 bCZH1fGuTcMX7bpSa+HTZkAwytm1Fkzijmj4Ap7HPfoXzZE5+jP9Oeu+dNo17W/gaT36owUYN
 gH0LMnUYJ0FrmJrBtQnforjdeQk2TWwPcEs05PKd1K3yJzxoI5/WvrY8TVhV39fVOfIJxLbJ+
 LUvUa+rl/LFAFy5f1NQZDOOD/FO4RyPW/r5i4Yd5J4Hg78SPElc6RIxzvQ0yQ67jqIFz4/MlH
 juvLzKkXskda8IXwkiP0kGCJJMCYGFg1/GOGCR9OChgT/2F9ZtmP4OMVaOk9ecdtklOA1VAyq
 P8+9Vnral8RnpbrIeOh/TZJktiCxaQG16GopmRP3BlbMIvMNZhULxL5il1Q9lm478Z+Yefm2o
 jXTYrnEzeD1f+mKRQkot1rBaIxLBQc68ABPk4sUmPVXZ/0ORJn70BvzHKZcNirJ2gC45xKVqR
 qzQIjEGenlECR9Kb2NNmjruKlnZ3f6m03cOMcNqLDPtBLC5O5A=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Feb 2018 17:51:23 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Return an error code only as a constant

 drivers/i2c/busses/i2c-tiny-usb.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

-- 
2.16.1
