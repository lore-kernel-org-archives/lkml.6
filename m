Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-807177-1523400647-2-6821451570270611547
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523400647; b=ZGuxxBH8khEQyXQAGI8WS5tHhwK3FQCylx2N33Rx/i3fuKFu2K
    8axFIb5v7lDZGI/neZfUYle29Yj0w1ikjnEfcDByu/DlzxwmCH0YOMKyX8CGai11
    uqO6L8Iyw+ngm7sRU/tUYwwMyFoUyWNC8GeQmQauOV5EAaSdQGOi6E0ynNtAS2L6
    DGDDGg/u8ZpsiuKcYIF5yX1V+YjBmiEDC1wQ3xFyxW8T17nV6VtyvDvO+QZJJ7wE
    CrsVsgYvu5I5y6ysvwmbel5U7iiCf2E1GWnh55Rf2YnysttCxwE0M4SMRdz1BXNf
    RmrMLwVJyoQlE/DUDtHfC4dTkRO3QWwkLvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1523400647; bh=O0J5kgM0WVVmR4U7j5ot5yqbqz4bhp
    pJ1jrdDOsL3rg=; b=HoNm3+uW6qnycQFIoi7oyzjauiSlKBwHxtSumUA8my0MNn
    qNQrTalL0PixMkuDLMxDQVeUGGq8D/gc/JRlSnRqmXbu5ZQl2wnSGLuCeTBdeHTL
    X8wYgbDJeGdQO+lZFmXlQy6GLX8xYfGfA/MeI6fddNf5tYivlj+VfVgrSr85ErAF
    hTniBFSOIhfT/yD93z08LfgR0pc26k2ZeQy1VUHbaAWoxV8bArc0mhhpH6RtxreP
    xRp0aDuSc+RQTjV5gfuCWy2QNRZwWXwsfzKw5PMzQahqQ10C/dZ8//PN24h19BFk
    UwJmhu+zrEseu9d+BsW5DbvRpO4sC9fxTtukgoOg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFnNPusYq2mPumS7t5GElnTm3oW8/YHGQWOyHEm0EycX1/rXKIW5+T3Ymeb3R+h+WEEWbC2kaoFN9Vh6CqNVFuPjgbttyIzesBXjuY79cEOk6LkqNdW6
    wNHFZcDW/XfZOCUfsFsJ0ferxezMyNgLlrIlxCbkU+0QGZWDnB3v+aRGqfib+YzR8ZMziXgRL4fmc+bROoMrDsK8sKOqDSSaXE/tdx/a/6lDqNrU7GFxUpnX
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=8DBI-e0klOL1j4GzEy8A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755659AbeDJWtG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:49:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:33618 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752865AbeDJWtF (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 18:49:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,433,1517904000";
   d="scan'208";a="45166873"
Subject: [PATCH 0/5] libnvdimm: fix locked status detection
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: stable@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2018 15:39:09 -0700
Message-ID: <152339994885.16061.1760220735664848631.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The new ACPI _LSx methods moved the 'dimm locked' error status from the
result of ND_CMD_GET_CONFIG_SIZE to an error status result of
ND_CMD_GET_CONFIG_DATA. Error code translation prevents the proper error
code from making it back to the 'nd_dimm' driver.

Fix the error code propagation and add some unit test infrastructure for
regression testing this case.

---

Dan Williams (5):
      libnvdimm, dimm: handle EACCES failures from label reads
      tools/testing/nvdimm: allow custom error code injection
      tools/testing/nvdimm: support nfit_test_dimm attributes under nfit_test.1
      tools/testing/nvdimm: fix missing newline in nfit_test_dimm 'handle' attribute
      tools/testing/nvdimm: enable labels for nfit_test.1 dimms


 drivers/nvdimm/dimm_devs.c       |   22 +++++-----
 tools/testing/nvdimm/test/nfit.c |   84 +++++++++++++++++++++++++++++---------
 2 files changed, 77 insertions(+), 29 deletions(-)
