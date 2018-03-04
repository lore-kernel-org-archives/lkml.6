Return-Path: <shreeya.patel23498@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520166871; cv=none;
        d=google.com; s=arc-20160816;
        b=jXCaMQvzSCRAEhCagfj69kyhH1UDMFH1q6u4GGjsfbL53bfpNBTbElZpkkEKbMlmkQ
         9Wgnb1JB5N+YXxZALasOxPq76O0dNpNwoC2Bk8TR6VUD0QPm2qnhD8XHMKfXW4b+A0Kw
         Y/S6cLm4zdf4oMdzLz+hXeycQmim3arClo9nuQBsV3FAsVakqCmLzOMoW8r8sGEVkCux
         1DBAaclhJKorgdzSCkuBHhTa6Knrw+0SSpiIUdAStqRKPtXTqAlAb8/2Yr6SMbGWy6/f
         YjbGLguFiiykJnFTMzO00QSWDmMTP1J9f2lHCCD+Wb4GYu3bw6eJ5EPxJAubswp3kCS0
         2+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=MDRAh+ugDZ2KxnPxnGD+YrQWL0ufk8/wIwj6TsOd52o=;
        b=Xl6pdiZzIspMvmTVfkc24g9pWxx6fj1LzAPaQy84shFvhVD7ZO2AjGeUk82mi9jTef
         N2iVRLg2ibdWaOq+X4OHNf0WRKLXeDZrhnzNpyKFf1UZqxgIzSNC1z7VMnvnb3Y/PkTI
         q8K+cXrRxax7z2HoU1kR4mJcSdjrHwNOYO1KHHVFD+eK5PUIuZLgiO+625yL9vgp8zlV
         8sD39Ya4R1VDENaOq/vmfS6rf3P7nKBqHv7q1m+TpgDPob+g1FvvngBV7xMV/eBjAequ
         9SLhJHztCtTIvg0YwB1t3RGYpyBRoCF1d5Nky8UfUJwmLRFmvWAqhW+bQCttVP+L4EYv
         GjcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JS04xvD8;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JS04xvD8;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELt6wzUObfvcPJlUeNo/dOU6YPl5Am1BW8dZne4jYb+vNR9MWLoXIT+hWWCSXzQSbZPxxSBbQg==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH v3 0/4] adis16209 driver cleanup
Date: Sun,  4 Mar 2018 18:04:26 +0530
Message-Id: <cover.1520164945.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594010497688624678?=
X-GMAIL-MSGID: =?utf-8?q?1594010497688624678?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset has been introduced for the cleanup of
adis16209 driver.
This patchset cleans up miscellaneous code fragments
and improves the code readability.

Changes in v3
  -Combine some patches into one from the previous series
and add some more comments in patch *[1/4].
Introduce a new patch *[2/3] for more cleanup.
Also split the last patch of the previous series into two
patches.

Changes in v2
  -Split patches and redo the series.

Shreeya Patel (4):
  Staging: iio: adis16209: Remove and add some comments and group the
    definitions
  Staging: iio: adis16209: Change some macro names
  Staging: iio: adis16209: Adjust a switch statement
  Staging: iio: adis16209: Use sign_extend32 function

 drivers/staging/iio/accel/adis16209.c | 183 +++++++++++++---------------------
 1 file changed, 67 insertions(+), 116 deletions(-)

-- 
2.7.4
