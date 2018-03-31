Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1160787-1522476726-2-16805012616992290895
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endanl, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476725; b=p2NydSVPAekfdGKCfzRu+dRD1OTcO3agF1gZRyeC/wr4b8oBnd
    4dhOgk4JPYSYmw5BuDk49f8WzJ5EyG4WfeoGmVGIe41+FUH1OryAPwyAVyeaDuAn
    xejEUZnwyoa19zQazOBizq4zWb7CBGtUB2ho0rmdmUrbjwldC3g+0ewBxyTy9A7W
    SZQYrSau8+yy+1oc7DxgXIXCOILcTRWGJJuV1vDVB5qNyeq2fmtu0pQ/kCncUJYP
    htkME/OnniK+pkIw7NRdI1owrn9bmWZgL4WuAPOAjhSxios+ykWtIWpyi7PEw70h
    7IiL2CoNLTnNLNwTYgD1hudjJ+wClFlBT4Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476725; bh=mewPU
    A1a7j5mOdcxvYrU+rmvbWBzq2VjP72X7NhvOek=; b=LSsGpepqCZkOtWh2hY98x
    +j7rjM+EwuADkhBZJX+omGMt2XrjWD5YBJsyqAS3Wp+E7TFvsO0mEU6tz/igPmIh
    yBhC5x+7Lu+6rO+fjHdX8CrKx9SJfga5abnguq9u4Fu+VhBbMEozjXWtzRRjPSxB
    eF26W03bOWWIO//AWdgue8IDhtaCgY879t3OGRlJ+/VSo2AuTmJYTozMcZVyCsO/
    BIcm8RPMyhiY5oK8tGZDw2lykCM4Z1O7xL08FVtvLlO4h4X4VHP+FNiin9oTNhw/
    jkswgJyTOzXY7EHZH6gdWhHyif9YAjuvin+TBdm7pZvOV3+4hnZPVFRpdIGaYFL9
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPYVuUbwD5DDQunBDX7hGIQ5VZJWMbkL/HjiXnx+D0J4uOWxpdnb/ETOV0FS4ouAXMhFEM8BCvyfBlBq8yqJlKQLbFh0CdRBjoTYXzGoLE6jrEuPk0um
    ZEyqvfEOJb9Y6vPcKSkDemNQiVH3BheL4UMbsZGk86xgEWnHv6rrFLn2VdBaCRbBxBjgH82ulcEiMb7jXzglHKSwa6oOV93EEFBQ1jKPHC6Bfi1rRrT1RHdX
    xtlhnGTAP4Xt/f/n4z2Ohw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=MBXM6yTHWV4dAfAIpPMA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 59/75] staging: ks7010: Remove trailing _t from 'struct
 sleep_status_t'.
Date: Fri, 30 Mar 2018 23:08:39 -0700
Message-Id: <20180331060855.9452-59-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:lqINBSkNAENt7ttNhz/cRuAHgwxRLJUS/XVI8cndyVeIx6RvrPx
 mbDqeGKsXAvRrgDUYmPsKndXiTZu+yEbDYmzWztbQ2tvSg5HpJ+Whnk3CKqQiCWy1nup08r
 Rw9nAiawEeqrwW1f20SulyKi3CkZtKKLWjhGz4CtN+UXResoebVO3NMrwBM74HVOouRC9qv
 i4GQfOg4sM9uuk8BZ+Glg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lh9SVGZsDUk=:SLPSmBL6mKRKJMx9I0KZVd
 aukPpLwqo8DvKT/IT+nB+RXLyjoLjx+GkUiVXEF9z17XxNU4vMGeEoZBMQ/YfV8/O+irTCVDG
 lYeLp6h2tX4VnwqJlRWH/2UfQ64gyh/ZO8du5VnAylzXRpt8J/oyrFdCepyP1Fa2o/661FpLX
 cH3+moZKg637KeKu4378b10LpzDxme8V2hdyj4bQ0rRTkr+EKi8wQjyE73UCYdzE8jMkgJKqg
 Lc0khHh/o5KfWtvstsQg0uJ7DWI2O2SjMy5eefuDyhE73TS/FH+t299Kyt71hw6APw1JZc4kG
 FhmH+fKrtT8nWG2yM4nHpZQxSog771EyXskPACwPSqiRFXjY45iHYEhjxSeFjSvK/EZe6c4FU
 86rRsJGWIzSFVPf3+xHLEjVW6wVsCteg0gIuP8yYMNlCq2y6NCgUfllarTDHhDZxaCu/rx8ED
 qV5VRPLRWozH3pxln2kkhCUCEh5kCn86Qao0IpFjz6lk6j/UwemJfqtly9x8UB6j4vidML1TQ
 9HazavVwnNY5pkPJWX59Ni4DUWAHooawI+j/5ZK4IgsNhN4hDT90DaaBerTCV/Y9D4Qdma+Oc
 UnYFnRRDcaTyaQSZKamuuToerfAJmxIl0wJ2H5O8C/2vgfMGiklHH2YTgsjelQTKNOrrCOBEd
 QGRBe+udsFUQbSmDvR/CHt/LzfcYc4eKdY4Np+vHizXhZsVL2nwgxFauDp8MOZ1gPDQY9EPa4
 jQ5S09GFOzSWKTyp6kKMR6DirIWdYK1uuCoV/O/8Gi16hDYgPEP3ktPnGwSLxPqb7q6k2r7T5
 felDzm+ndcmp0fVAAtmrQTFmkqXwaAn8W1dTIBbgo+bg6YKCBVvRJLfJo2pjlIjpFScD/vfCm
 xCX5SrsW3ERY2SLIlWHAWkeQ6d6mYJBqjGBXfnDfl5kpzmCa43a628siyqElMO
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

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct sleep_status_t' with 'struct sleep_status'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index edd13060c24c..d10ad152aa32 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -285,7 +285,7 @@ struct power_save_status {
 	atomic_t snooze_guard;
 };
 
-struct sleep_status_t {
+struct sleep_status {
 	atomic_t status;	/* initialvalue 0 */
 	atomic_t doze_request;
 	atomic_t wakeup_request;
@@ -426,7 +426,7 @@ struct ks_wlan_private {
 	struct local_aplist aplist;
 	struct local_ap current_ap;
 	struct power_save_status psstatus;
-	struct sleep_status_t sleepstatus;
+	struct sleep_status sleepstatus;
 	struct wpa_status_t wpa;
 	struct pmk_list_t pmklist;
 	/* wireless parameter */
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
