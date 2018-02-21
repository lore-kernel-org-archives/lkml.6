Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2260ljlJ1pIpLsnVFHjnRlvRDzTRQnAjwE+Kvnmz7LcJE0jldr4BkqDVM/1J2xNjfOYoGUSy
ARC-Seal: i=1; a=rsa-sha256; t=1519217761; cv=none;
        d=google.com; s=arc-20160816;
        b=PrAWlbBZOWyXP/1+A8X8OLdqyxHpj7XfjCNz2eJ8nJljwaRF5NM/dS7EM1kcpGc5gP
         wY/J4vXITnrPQ4McD5mM57gqg9msF1Y3m46tk8snOagWW4FD4y/kuwll/8J3UKZGbbQi
         HIhjJlyk3rDaQfuu6VED9fW4EV+cv9eKbLWiCK5Tb4TyfxCCYUG5sHXQE9t8CFKYPr43
         J1zd6wci/VU+MTadL3lMNWSwfCtxPH+ZQJfzW7e0iJ/1m+qJR1qSq+QdpU2TzHTeqyJa
         SHIyDXyCFHDgoRkh/h+pdLweedG2nP7sybGXSbAVTSYQCieWRzZIDniT3HDT5rUfhehH
         2mQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c+OhXgqczLNLUcu2iq46ZcyUj+E/uqOa2k+kKwnTEhs=;
        b=tJ1NbAXnznGsnlUpPeIP7yJo9Q0dZtu4brRsFRoa8lJ/24BGsJ57qXSAVYn2rbYxYP
         hzADooWhSYdmuFohVITi5QyG8oe+8cOpBq1lfLNEVDUy9GKvxZ4t9fp5m76pjmw3W295
         JzHu+NLi7T3JWNTEa4/8gUN0TkZWKbeLInK1jgDshkdhtIVX+0trSxU2xAkDgvTnid5Y
         Qr1nt4jWzGPLQQ6XH8Z1+6c4McM68gNHF210npwlHzlX6njKEaSo4LWO9UFOL/bSz+9o
         2LA8F4I7k8vJkSUFZRKXKXcRmtHV/Cx2a/gNB6S2ES5At/yqcKYMicOx2BNm1eldWuEU
         Varw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"=?UTF-8?q?Ernesto=20A . =20Fern=C3=A1ndez?=" <ernesto.mnd.fernandez@gmail.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.9 09/77] ext4: correct documentation for grpid mount option
Date: Wed, 21 Feb 2018 13:48:18 +0100
Message-Id: <20180221124432.558409040@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015282752811367?=
X-GMAIL-MSGID: =?utf-8?q?1593015282752811367?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>

commit 9f0372488cc9243018a812e8cfbf27de650b187b upstream.

The grpid option is currently described as being the same as nogrpid.

Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/filesystems/ext4.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/filesystems/ext4.txt
+++ b/Documentation/filesystems/ext4.txt
@@ -233,7 +233,7 @@ data_err=ignore(*)	Just print an error m
 data_err=abort		Abort the journal if an error occurs in a file
 			data buffer in ordered mode.
 
-grpid			Give objects the same group ID as their creator.
+grpid			New objects have the group ID of their parent.
 bsdgroups
 
 nogrpid		(*)	New objects have the group ID of their creator.
