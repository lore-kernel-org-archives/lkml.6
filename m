Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+oG5njcGh7zUKu3zsZvRjl1iY07JndIHgNCMA/Xrt559HFxQF8pGeItQUWm3XdlOdThnhA
ARC-Seal: i=1; a=rsa-sha256; t=1524523997; cv=none;
        d=google.com; s=arc-20160816;
        b=oljdN/zIEhdHkGKL/XRTLG1PDetzIWqZZJ+lp2Y4G2icw1ASW5GylYBjc+CKt2f+yx
         OBVWhatDXiKkyY9OSaJaETmGUwoXecL9586ymvvhUD7NsdOoonwxl6OuKyoefyx2VR1P
         rMSpgEo/Wb46pl99hZFwuTuQAquR7HTLf8Ye+y7ipZ+R5EC2Bj8JIXXlZ0WpD94pAQQN
         WgAVYHQecd6rI2Ci4CFlI+m7ftYhg/e482DHvrNyTGi+oS5Nn3jSNfVlJqG2QXHJ648c
         wMOjOoVWG1sfFaT0xbcbEhbFRpkiCQM6C8SuAtHxOxQ5w3raOtms426SL+3bSiZQPm89
         KXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=9ImwVNjblUePd2FPlfBOZvw8y4jyjXi/CSCJ6Owb+GI=;
        b=YvInDPxyYHjHHd/JLBunbqUS52Jm4GueyuWCUuAbu2pZ5n9KEOXXMxkf7bagtm/XKS
         QSEs9i1Cmuxzdlpqphw3mqGR2G9eghNeoTT/SyLV64nXwfB2/uLk7Zpr0a4iwlkrzH/d
         VMqfHCzYbs/486vin4Z7QQF5rftald6PFJeQ/9/hcOu+m5kZzs5e47L/IgzcgsKagrT8
         Vrc+amLGr1MOAwTeIdw4YXyBCKiy3eEWlq84/OWlVRnupf02mmEd/iiWXFkRyBeeg9LN
         IJc4W2XRsuV6yQ6K3UBm47R9dvwFT8KLeZAvd4uh4mJwtKOtYwr8yW5ubsTcgL+s3JYo
         SvWw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=ckheoDty;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=ckheoDty;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932585AbeDWWxP (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 23 Apr 2018 18:53:15 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36452 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbeDWWxO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Apr 2018 18:53:14 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] selftests: bpf: update .gitignore with missing file
Date: Tue, 24 Apr 2018 00:53:05 +0200
Message-Id: <20180423225305.18947-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <065a8bc2-6065-3d43-8b03-35ed693de7ce@iogearbox.net>
References: <065a8bc2-6065-3d43-8b03-35ed693de7ce@iogearbox.net>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598545167658218974?=
X-GMAIL-MSGID: =?utf-8?q?1598579274716180220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes: c0fa1b6c3efc ("bpf: btf: Add BTF tests")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
Rebased against bpf-next.

 tools/testing/selftests/bpf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 9cf83f895d98..da19f0562bf8 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -12,3 +12,4 @@ test_tcpbpf_user
 test_verifier_log
 feature
 test_libbpf_open
+test_btf
-- 
2.17.0

