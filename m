Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1186102-1525707700-2-12872618745087940165
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525707699; b=aRW5mffDBbIowVw1FqYmFzJ4zBCN3ipGMEP2cGzDK9jpQHTYfq
    zdnBCLqgxVH5NUME3NKf5X0VS8vQ2hRvAr1yPv94S8z23H9SSYaDpCLwVYRuSskp
    +pqNL5bDjDBGrI12lB+O84nWaeOCG1MyCeFxNSIr6rqofWD0jkXc2/ma87ypaDsH
    QTjYECyW2hvOpbUAL/NvANGjS+kB7TLZkVtMxRglXHcsVBgy+mKKLmCcJGp6GvkB
    SLepsljJkrC70O3kGt+Zke7wh8xxDmNyf6H0xNRVftLgLmyOnAFQMpJNG09xSA3n
    UhMxoLYnRvaSCAOtyghoKk8P9T2Y0yllkw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525707699; bh=d5gZtTNhVL76Yl1pwrj6b1g2yZu/jo
    OCa0Tf/EQFh6k=; b=OuEVJK3qhyy2d/xdYCqoSwHQynbFLHXykULk5gLmvqtFRY
    2EvwRVtcOHvFgNZlm2oQM/Vgrg69EzN/uYZEmDGIPJCKv9LOU3hhmHFms8gyCdY+
    plJxXY1ztX24to4j3yiOLXiSX9py2m2tgZLncijJbQFk69etg2td5AQPqqsUqwRS
    6c5KKu0E974oesz5ghAnAukrxLwd693GDFJmiHWPTsWonUR2MIBhbKM6dGQUTYHg
    HpB09nWk93spVSA865Z50I59bnJ2KqG5YILUkfgKhHdmA0HDF+OS4uGlLLUAiCHH
    vXdfbgu41KHAW/CRrviSQei8uqwWldxpRyMkiCEw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHBqdznpOrbN+qjR1nVjlwJMlZfts14RJWYD/xkmT/z6wZrjVotLPSGdPGuTVTq3xdBHnSRVSHi9w8djkCI276zb49mIO5ekwks3IqRHBs4WvbTYl5oO
    ST91Zm+NQ98CB8EJDYmo2NF2BovU9Y1lIfWsur/SWPw3gj1uYUmkPskdY2cglg3xWXx/lYj6hoPTYOknRefKJ7AzrtzzVhq9swhgxQb/YEE4CpFIJDLFOktj
    NYypXr0zb2t9tLmvklH88g==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8
    a=VwQbUJbxAAAA:8 a=VTL60bhbW18Scj4dS3wA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeEGPlh (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 11:41:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752069AbeEGPlg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 May 2018 11:41:36 -0400
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v2] tpm: check selftest status before retrying full selftest
Date: Mon,  7 May 2018 21:09:41 +0530
X-Mailer: git-send-email 2.13.6
X-TM-AS-GCONF: 00
x-cbid: 18050715-0020-0000-0000-0000041A0319
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050715-0021-0000-0000-000042AF3742
Message-Id: <20180507153941.4952-1-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070158
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As per the TCG Specification[1][2], RC_COMMAND_CODE indicates that the TPM
command is not implemented or not supported. When RC_COMMAND_CODE is
returned in response to the partial selftest, this is not the case. TPM 2.0
supports TPM2_GetTestResult[3], which can be used to check the selftest
status before sending the full selftest command.

This patch implements the tpm2_get_selftest_result function to check the
selftest status when partial selftest returns RC_COMMAND_CODE.

This change results in finishing of the selftest much earlier compared to
the existing case where full selftest is immediately sent to retry. The
Pi's dmesg shows: the TPM selftest completed at 1.243864 secs compared
with the previous timestamp of 1.939667 secs.

[1] As per the TCG Specification, Trusted Platform Module Library,
Part 2 - Structures, Section 6.6.3 and Section 4.18:

"RC_COMMAND_CODE indicates the response code that is returned if the TPM is
unmarshalling a value that it expects to be a TPM_CC and the input value is
not in the table."

[2] As per the TCG Specification, Trusted Platform Module Library,
Part 2 - Commands, Section 5.2:

"The TPM shall successfully unmarshal a TPM_CC and verify that the command
is implemented (TPM_RC_COMMAND_CODE)."

[3] As per the TCG Specification, Trusted Platform Module Library,
Part 2 - Commands, Section 10.4:

"This command(TPM2_GetTestResult) returns manufacturer-specific information
regarding the results of a self-test and an indication of the test status."

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
Tested-by: Mimi Zohar <zohar@linux.vnet.ibm.com> (on Pi with TPM 2.0)
---

Changelog v2:
* changed the subject and updated patch description
* removed the logs

 drivers/char/tpm/tpm.h      |  2 ++
 drivers/char/tpm/tpm2-cmd.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index af3bb87d3ea1..1de4240b52c4 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -114,6 +114,7 @@ enum tpm2_return_codes {
 	TPM2_RC_FAILURE		= 0x0101,
 	TPM2_RC_DISABLED	= 0x0120,
 	TPM2_RC_COMMAND_CODE    = 0x0143,
+	TPM2_RC_NEEDS_TEST      = 0x0153,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
 	TPM2_RC_REFERENCE_H0	= 0x0910,
 	TPM2_RC_RETRY		= 0x0922,
@@ -144,6 +145,7 @@ enum tpm2_command_codes {
 	TPM2_CC_FLUSH_CONTEXT	= 0x0165,
 	TPM2_CC_GET_CAPABILITY	= 0x017A,
 	TPM2_CC_GET_RANDOM	= 0x017B,
+	TPM2_CC_GET_TEST_RESULT = 0x017C,
 	TPM2_CC_PCR_READ	= 0x017E,
 	TPM2_CC_PCR_EXTEND	= 0x0182,
 	TPM2_CC_LAST		= 0x018F,
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 96c77c8e7f40..4abba0ebe25b 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -825,6 +825,50 @@ unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 EXPORT_SYMBOL_GPL(tpm2_calc_ordinal_duration);
 
 /**
+ * tpm2_get_selftest_result() - get the status of self tests
+ *
+ * @chip: TPM chip to use
+ *
+ * Return: If error return rc, else return the result of the self tests.
+ * TPM_RC_NEEDS_TESTING: No self tests are done. Needs testing.
+ * TPM_RC_TESTING: Self tests are in progress.
+ * TPM_RC_SUCCESS: Self tests completed successfully.
+ * TPM_RC_FAILURE: Self tests completed failure.
+ *
+ * This function can be used to check the status of self tests on the TPM.
+ */
+static int tpm2_get_selftest_result(struct tpm_chip *chip)
+{
+	struct tpm_buf buf;
+	int rc;
+	int test_result;
+	uint16_t data_size;
+	int len;
+	const struct tpm_output_header *header;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_TEST_RESULT);
+	if (rc)
+		return rc;
+
+	len = tpm_transmit(chip, NULL, buf.data, PAGE_SIZE, 0);
+	if (len <  0)
+		return len;
+
+	header = (struct tpm_output_header *)buf.data;
+
+	rc = be32_to_cpu(header->return_code);
+	if (rc)
+		return rc;
+
+	data_size = be16_to_cpup((__be16 *)&buf.data[TPM_HEADER_SIZE]);
+
+	test_result = be32_to_cpup((__be32 *)
+			(&buf.data[TPM_HEADER_SIZE + 2 + data_size]));
+
+	return test_result;
+}
+
+/**
  * tpm2_do_selftest() - ensure that all self tests have passed
  *
  * @chip: TPM chip to use
@@ -853,6 +897,10 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
 				      "attempting the self test");
 		tpm_buf_destroy(&buf);
 
+		/* Check the selftest status */
+		if (rc == TPM2_RC_COMMAND_CODE)
+			rc = tpm2_get_selftest_result(chip);
+
 		if (rc == TPM2_RC_TESTING)
 			rc = TPM2_RC_SUCCESS;
 		if (rc == TPM2_RC_INITIALIZE || rc == TPM2_RC_SUCCESS)
-- 
2.13.6

