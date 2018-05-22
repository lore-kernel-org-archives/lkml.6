Return-Path: <ahiliation@yahoo.co.in>
X-Google-Smtp-Source: AB8JxZrPX5Jz8REgSUv3p0KY9DZPQq5x8zCmSvgT9LiYHv1uOGrKi6UwPHU4hDyWFS8EEkxvSNoQ
ARC-Seal: i=1; a=rsa-sha256; t=1527008761; cv=none;
        d=google.com; s=arc-20160816;
        b=f10NY7wVKgvDHN7phISfmfl+22qhF8IeORthsOzbp7APK0cYYek5H6BoGUqDy9WmH8
         nNObLfdugudWt9cwY4ZXTaNz0bx5q3XrouW3kT/uyJhD0OhJ5KTrUu+jqbpZSVuV0E7O
         2tcwOIUS4lkmC10/6aR9S+y24SfPLlvg6InktjMT1OY3nW1aYxr+uG8xZhHllgoDrY6K
         ygr8J6gVZtSNwDyIJkPK7U5qVlEif6mmr3VrVhDDjDvbgHsFZyrRSCoVmE4+w+OCcGVl
         bDJifISVHxFJx4mD+vi48go/dFHjqsehGJ8XoUaJkX1l3DQYe6AW+bBXS5ePCQNaeKsb
         EBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=xpc010XgTK2PzOLDKZf/dmWhCBF86ki0WlbzP2tsijQ=;
        b=yHZLzoVtyGqOrSrmajubAEnVyDkL7TXQm7g5JtgyMKwHdGJXL/CqkLa2eAA29/aLUe
         0QQgdjXxKnZtim8TV0/Zu4Z60m3RVtR5LZOIMdW3nfCLgS3GqMit7xBC7tf+KzbO5Uug
         NUKU6SPVAx2CQlXliz9CLr9x/42ftkKl2zm8t076SRdDLPbm1TFyI7BDBhiIzLIkHer4
         hmVZaRFvAhqojAuhS+O19aad8cdvpWLvIk42xnPH+03MddADNugjYrJU9x+mFYEZa9/u
         nuLywzNwVA4jgCUb6izQgQ74/UdTJIAnBfYidHGNxRZYlZKN3Dj7sIO7uPvuqMiNDZJE
         Vu4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=PRyv6LEb;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.244.40 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=PRyv6LEb;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.244.40 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
X-YMail-OSG: O1EySCcVM1m_DK3_kjNq5FmtshSPgsvqisAfmddP5U_7QUCCvgYBw2Z_aTlYNj8
 qGA0P.of97QcCKi6Kp0pm5evxYBR5_tCMC3EZ7ZMP5TXFPcctKmIAXm5lq_Y42tPrgs5P0mDmVze
 ZmOVzoAsY0a4qPmyql4kgHp_mFG0aeicgcsoxMhuI6zDqVtTIx2wXTfxiOW1MawoOGDUYHQb365b
 LDp4V8ZNt9dCPVRs5IhLKXorjKGo.aHDFOldqthYYnW7MAYGmR28XNJpEBa6QIs8NNP9B.xBzh6c
 Z6JbpYzWFuK.M2SPBDjLd7sZAQD..D2XyG3x9pgSjBylWPFMTORov9h43sudi3Dc.WeuCzFyCGM9
 2c14nWADC5rDiNMPLumcZMvmCqpGlSnIeTsUmgbF5qlQvti_cWVGhrGOE0Qna0XxY.TwFo2l17m7
 6wMwJ1EvBGJDCOmDM8e9rcdEzsUDUOPkJAeM2JD8QKxPCBPIGQCYUYU.AJxW4rkLzPWlsO2qDIiO
 gu2J9J0Yx3f.abkSxDYDHno2W2Gevc3F.ZIa5otdIxIi2ei3R71n3u57O.FkfyAk5PHGeRZ0ZD6c
 00Lr6_NWx4nfBO5ZJoXQXP295M2GfFZgclqy5ui6fPHGki3dftfh.ZJ7sqVudQkHlGLrH5Iujn5i
 9taQbhD1.vYJtHjSF8Of6F0nY8cMcnSYJ
From: Jeffrin Jose T <ahiliation@yahoo.co.in>
To: shuah@kernel.org,
	gregkh@linuxfoundation.org,
	daniel.diaz@linaro.org,
	thomas@m3y3r.de,
	pombredanne@nexb.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffrin Jose T <ahiliation@yahoo.co.in>,
	Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Subject: [PATCH] selftests: intel_pstate: Fixes for the testing script for Intel P-State driver
Date: Tue, 22 May 2018 22:35:05 +0530
Message-Id: <20180522170505.5846-1-ahiliation@yahoo.co.in>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601184738922381794?=
X-GMAIL-MSGID: =?utf-8?q?1601184738922381794?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

fix for notification of permission requirement to run test.
fix for exit status value for test skipped.

Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
---
 tools/testing/selftests/intel_pstate/run.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index 6ded61670f6d..4ddd389c2cb9 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -33,6 +33,12 @@ EVALUATE_ONLY=0
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+msg="skip all tests:"
+if [ $UID != 0 ] && [ $EVALUATE_ONLY == 0 ]; then
+    echo $msg please run this as root >&2
+    exit $ksft_skip
+fi
+
 if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
 	echo "$0 # Skipped: Test can only run on x86 architectures."
 	exit $ksft_skip
-- 
2.17.0
