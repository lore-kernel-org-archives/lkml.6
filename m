Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2161282-1521181866-8-1520785419083915552
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521181866; b=C6noHSZ25LMzQW7XGZN0Y4PWy4ROIMP/bZrrgrqp88vV7Gi
    l8u0JlOuuGdjv9V9fPqz6KqKLJdDgoPxdkMbGTNl6ZHxGZckw3fqvujKBufGaszw
    aX6n25xN8TxvCvPrh7M/HRxLIMCG5aFu9QxUkY2SrtXlAcrSRvxmvuN2leS0tki4
    susaZz2kKxd+efOi9EQsQwAOLaFa6ONZAcpKwcHZPEzcJyd9lyt3aQ/5l+RmCos8
    kd/EoJUX9iI85q/DQYXrCOiIHXYrrJk9XLIHLWMewurUu/oOPLa0iN06tfDyjZgD
    qivJAYyl9hj4TO73OJohlVv8c6rvGy6PQlagr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521181866; bh=T
    dF306mnMStNp3BtK9Bt6dVnVG1/q07tT2syBDlr7SE=; b=H1cRkN0v1jWV330yn
    dmOeDk4fBWE/1BG5b2mJDNdu3itjHny23CPXy4WqfFuVSBQIO/0exJGhjt6Kfo7w
    j1cPn0xdsY//wYxv6s7jMpjnyUPUhv90wLtt6XT8Pld9U8TK1Fos61/osvNJeW9A
    5dL0IGn4GML7WzM4TQhEkpXf7nVVXV5r7iJiFWg912uoFRaBju8v1wdPixZz6iV2
    PbhyZUUEMTbw1O9fxu2rNxGZNl9XS6GD2faAzsx5enoR68GZaISYm984shyCYTit
    fcTDtoiemmyHRThL8KUsBAg9cPKzjbe8vqJcRXqjIvpEDc/7YlzVmYWaO4/g4hMs
    bd+HQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 4/6] staging: ks7010: Remove unnecessary braces.
Date: Thu, 15 Mar 2018 23:30:33 -0700
Message-Id: <20180316063035.3037-3-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316063035.3037-1-quytelda@tamalin.org>
References: <20180316063035.3037-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:w3BjFT4CjvQLmzPLnJoIwuYv0hRFODoccKupPYN8VE6s1f54LDh
 8UpJPQiBQyQ7EA6ouPLpsHxccTYlKcZosfxYo+4gLlF83KJDBob7mzqjuNsjJjhAiIur/PC
 JV1uI3Q99+kr6sInxUKD3WsB8X14KeXC+XuJ/Uq9H5N0eqg7HvSMKdogO8ZE5OI1XVC9Wwp
 Ot9mxMv2tOdZcp3vah3yA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d005+mjLZ0g=:BhSe9XzIxsXZwSPFkXid7r
 NX5ImMpsxypzX8vZB/VfNzwRSkkYzdjaE+VY9Hx9cUhNfm/Q1oF6ZXvJQeIW19Ei6/Wex/LLN
 5QnXE+EnZ8ubVJerVzvxOorBqplu5CohshjAfe+fmGxfJY5J5kZfEjbFHE/8bDg/JB1KjMzAy
 OU6BFU5NuwwTp3R5SvBckzubJMZpyvpoPaAgdkIWey6Pwt+MadtaFczFLCanNqpZfenVDsYor
 SdCopedolPNMPIDWvWzrLjtxx7aF9wJTmmA5ZyRCAsB2ta9cRkyxVie9mD0BdhoHDg2Beig5/
 kpOw8yMntUTJMYbEJ3MPgRZ1sAqVqQYslcrFXgHL5IFyFIRVQ8lKNsLC+sejKDLPIF4ySzkfv
 6nMhudIqEet+X29k15tbgIKx2OlFcjBBdzlIKXL1gmU8fKSpYJgVxNwUv4mPxV+hEn6taxUe0
 /sLzj7Z08PLFmeOrWm27L0xpRt+K53TZsIBCoADIdfMa+UqSH6KMP/YlSuJYOfjmIZKl0nYCl
 Qr3D8S4/9YFO+qXvMfQKMSQLJ3/rd8mjlEJymKX1g/Vnfpyd1jw/m+zTjFJ75AXtM3GVjJ4E2
 JwrFWaEhQCG0owN68yccHnUTyo92VMquUsi/eGmzIjO8untqA5DtbfUXmgu4+xinMECzrdPxt
 Su9jqIGoSp7EAqekcPtmtNV1tFeGx/VtXJGrdz/7pggjIgWSG146Us8GP23IgueXpvREgbMZp
 U0nW1iuAxgYZa4E0YYuKcBA0J9kzi9frD/G59Q==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Braces aren't required for a single line if statement.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 00b97e8e9b4f..2de4dbbcd9de 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1387,9 +1387,8 @@ static __le16 ks_wlan_cap(struct ks_wlan_private *priv)
 {
 	u16 capability = 0x0000;
 
-	if (priv->reg.preamble == SHORT_PREAMBLE) {
+	if (priv->reg.preamble == SHORT_PREAMBLE)
 		capability |= WLAN_CAPABILITY_SHORT_PREAMBLE;
-	}
 
 	capability &= ~(WLAN_CAPABILITY_PBCC);	/* pbcc not support */
 
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
