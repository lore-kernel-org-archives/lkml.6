Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521483263-2-8486868251458823950
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521483262; b=WREXIL/m0+wNnDyeadSXp2wVqa6NozPIYv/c0g02hUas/PL
    bgjysihGe8il6fTa4HKQodoAxPMR6fVxlhXrEY6rQRpBJLcK8JrWnShhsmpOv7nd
    KyMaCoUMxYyxuABl/nZsGNdcvaqfAGQ+plctkWlsCBfoNd1K9VglVosWUapXmJAr
    uet+IbV0omx5WKt8vtTMf3WLF/FafKibvxXwRuIA5OQcwDNQEiJ3zbG4+1n752OD
    SZtLJZZ9E5gihiLUyCtPaXtuuo/VAlwxSeoSGAZiuPL3i6im19hwrhZZMyZTC+CB
    jQGLnigP2E+NhswL6qzc1Al0+zvQg6E1ez0jCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483262; bh=9NyzcrPUiuuAM+nJl1BKA4t/No
    XULB8+hsZqMrseStY=; b=kb5vhzxL+20+1C4Fue4mQ9VF8DarLQ3P0ES4ufmvLj
    mAT1/137fjTC3xUDuMixU6owJmXD9BLG8Iu9ME4TDIBJjNFgobL9MS89k/nra26T
    j7/AxdgMmQuXo6kC8mK974ZJZtsQx75jtoyivDbOcxigDnZmvMHq9wLkyDT+BaUO
    s/dJqb9P90j3cds04P6pOmcouH8nqDrGvKM0hq0ieJti0C3VPc9QYbDlSqLz0Iut
    NSo2ITlzVzDMhtWaB8yNUkVOh1DiLUtXOir8adUBlQHVCuNmU0b4PHekIrqOlPiH
    FwoXNBv106lOwg0bpV9a2pYvcYckOjjNYDVtLz8zehyg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeigeefkeenucevlhhushhtvghrufhiiigvpeekud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeigeefkeenucevlhhushhtvghrufhiiigvpeekud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968849AbeCSSOQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:14:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44028 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968844AbeCSSOM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:14:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Song Liu <songliubraving@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 055/134] scsi: ses: dont get power status of SES device slot on probe
Date: Mon, 19 Mar 2018 19:05:38 +0100
Message-Id: <20180319171857.297405634@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>


[ Upstream commit 75106523f39751390b5789b36ee1d213b3af1945 ]

The commit 08024885a2a3 ("ses: Add power_status to SES device slot")
introduced the 'power_status' attribute to enclosure components and
the associated callbacks.

There are 2 callbacks available to get the power status of a device:
1) ses_get_power_status() for 'struct enclosure_component_callbacks'
2) get_component_power_status() for the sysfs device attribute
(these are available for kernel-space and user-space, respectively.)

However, despite both methods being available to get power status
on demand, that commit also introduced a call to get power status
in ses_enclosure_data_process().

This dramatically increased the total probe time for SCSI devices
on larger configurations, because ses_enclosure_data_process() is
called several times during the SCSI devices probe and loops over
the component devices (but that is another problem, another patch).

That results in a tremendous continuous hammering of SCSI Receive
Diagnostics commands to the enclosure-services device, which does
delay the total probe time for the SCSI devices __significantly__:

  Originally, ~34 minutes on a system attached to ~170 disks:

    [ 9214.490703] mpt3sas version 13.100.00.00 loaded
    ...
    [11256.580231] scsi 17:0:177:0: qdepth(16), tagged(1), simple(0),
                   ordered(0), scsi_level(6), cmd_que(1)

  With this patch, it decreased to ~2.5 minutes -- a 13.6x faster

    [ 1002.992533] mpt3sas version 13.100.00.00 loaded
    ...
    [ 1151.978831] scsi 11:0:177:0: qdepth(16), tagged(1), simple(0),
                   ordered(0), scsi_level(6), cmd_que(1)

Back to the commit discussion.. on the ses_get_power_status() call
introduced in ses_enclosure_data_process(): impact of removing it.

That may possibly be in place to initialize the power status value
on device probe.  However, those 2 functions available to retrieve
that value _do_ automatically refresh/update it.  So the potential
benefit would be a direct access of the 'power_status' field which
does not use the callbacks...

But the only reader of 'struct enclosure_component::power_status'
is the get_component_power_status() callback for sysfs attribute,
and it _does_ check for and call the .get_power_status callback,
(which indeed is defined and implemented by that commit), so the
power status value is, again, automatically updated.

So, the remaining potential for a direct/non-callback access to
the power_status attribute would be out-of-tree modules -- well,
for those, if they are for whatever reason interested in values
that are set during device probe and not up-to-date by the time
they need it.. well, that would be curious.

Well, to handle that more properly, set the initial power state
value to '-1' (i.e., uninitialized) instead of '1' (power 'on'),
and check for it in that callback which may do an direct access
to the field value _if_ a callback function is not defined.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Fixes: 08024885a2a3 ("ses: Add power_status to SES device slot")
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/enclosure.c |    7 ++++++-
 drivers/scsi/ses.c       |    1 -
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -148,7 +148,7 @@ enclosure_register(struct device *dev, c
 	for (i = 0; i < components; i++) {
 		edev->component[i].number = -1;
 		edev->component[i].slot = -1;
-		edev->component[i].power_status = 1;
+		edev->component[i].power_status = -1;
 	}
 
 	mutex_lock(&container_list_lock);
@@ -600,6 +600,11 @@ static ssize_t get_component_power_statu
 
 	if (edev->cb->get_power_status)
 		edev->cb->get_power_status(edev, ecomp);
+
+	/* If still uninitialized, the callback failed or does not exist. */
+	if (ecomp->power_status == -1)
+		return (edev->cb->get_power_status) ? -EIO : -ENOTTY;
+
 	return snprintf(buf, 40, "%s\n", ecomp->power_status ? "on" : "off");
 }
 
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -546,7 +546,6 @@ static void ses_enclosure_data_process(s
 					ecomp = &edev->component[components++];
 
 				if (!IS_ERR(ecomp)) {
-					ses_get_power_status(edev, ecomp);
 					if (addl_desc_ptr)
 						ses_process_descriptor(
 							ecomp,
