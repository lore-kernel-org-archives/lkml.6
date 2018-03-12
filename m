Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeCLMW7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:22:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48764 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeCLMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:22:56 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180312122253euoutp0184d8bb62ac215dc5270603d92f0ef223~bK7k-yq6z0500505005euoutp01P
X-AuditID: cbfec7f2-5ffe19c000011644-a6-5aa6711accf1
Subject: Re: [PATCH v6 0/5] Add coupled regulators mechanism
To: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From: Maciej Purski <m.purski@samsung.com>
Message-id: <c6f43013-3d2e-afbc-9be8-2e07f58fda98@samsung.com>
Date: Mon, 12 Mar 2018 13:22:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <20180309155827.GS5799@atomide.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0gTYRjHeXe32205Oaflg4nCoDAhUzM40kTJ6gqiH5DEEPXSY1r+aqem
        FWHK0pQ0laVM8QfmCFGyuTQFE5cmmFnqLEsnjUxJKcg1MQjLeRP87/s838/7Ps/35SUxRYfY
        h0zNyOY0GWyakpDh3a//jB/0uW5QBZfUB9LPap+KaZ1tgaAbh8bF9FvDIEHbps/Ra5YSET3V
        V0/QHUNWCd36cUJEa/uHJPSA5UzULqa9oR0xa44qnKkrmMCZXr1Vwhjb7hNMuakNMXaj33mJ
        ShaRzKWl5nKaQ5GJspQlUw+W1eWR12JlCtCcvBRJSaDCoEZnw0qRjFRQTxBYBh4QQmFH0D9S
        J9mmGkcXcMEwIKgvbxALxSIC+89a3El5UhEw9920aZCkF3UCtI48J4NR8yJomrVu9QkqENqL
        E5xSTkXCWBntPIlT+0A337I1azd1GZp135BTyykPWK+ex524lAqGlZLDzjZGHYXFDa1Y0N5Q
        pP2EC9ofutp/bIUByk7A6vorXNg/Bp5ProgE7QnLIyZXLl+Yqi5zMbdgwtFHCPo23J3tdDHh
        YK8yYcIAd6jqrsGc+wAlh5J7CgFh4LOlw3V9NEzba5HwOgsIOkaaiIfIT78jjn5HBv2ODPod
        GZoQ3oa8uRw+Xc3xIRncjSCeTedzMtRBSZnpRrT5id5sjKy+QI7JK2ZEkUjpJo/qbFUpxGwu
        n59uRkBiSi/53AGDSiFPZvNvcprMBE1OGseb0V4SV3rL4wPuqBSUms3mrnFcFqfZdkWk1KcA
        7Xm8MhfbG85f8i+8mDR8/JfF5vhn1YSF9qq55sbgjcJl2/zXI2zecnd+7HToKaOsqrFopnh/
        zIfYCCZ6Jve0Pm80C5NWNKuGR2et+NkAKby/ql3KRIPhE3/dfCsrlRd+R31ZrEg8aTbGV7I5
        x3x74uPG4oi10Ufuorp3w5UvlTifwoYEYhqe/Q946AQqQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e/4ZV2JwmVRBjsX6VpsnLGe1WLqwyds
        FvOPnGO1OLvsIJvFw6v+Ft+udDBZXN41h81i7ZG77BZLr19ksmjde4TdYv8VLwdujzXz1jB6
        fPs6icVjdsNFFo+ds+6ye2xa1cnm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnPt2xnLtgs
        WLH4rkcD4x3eLkZODgkBE4n5p56wdDFycQgJLGGUmDTxHCuE84xR4krvVhaQKmEBG4k7L7cA
        JTg4RARcJVq/VoDUMAs8YJJYNmcbM1zD/E1NjCBFbAJaEmva40FMXgE7iTPdFiBjWARUJabe
        W8wOYosKREh0rpwPNp5XQFDix+R7LCDlnAIGEq87jEHCzAJmEl9eHmaFsMUlmltvskDY8hKb
        17xlnsAoMAtJ9ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYLxsO/Zz
        yw7GrnfBhxgFOBiVeHhnbFoaJcSaWFZcmXuIUYKDWUmE947msigh3pTEyqrUovz4otKc1OJD
        jNIcLErivOcNKqOEBNITS1KzU1MLUotgskwcnFINjOvuG0rceb3GS3Xnvvikd4aGs+/6fjqw
        cMdCt8WTX80KU19nfIrrSHBkvojstfM91j2xaitLt7ree1s6M9F4m46/jQRH9+31c/uX5Mz7
        0hryteu04Rz5K/sOl0xpKEsM47D7q9DPtfOXHCv3dsG249sd92hb6e359PJO1Ga3A/NvePMy
        zqgv/K3EUpyRaKjFXFScCACzxVFGkwIAAA==
X-CMS-MailID: 20180312122248eucas1p21529896cfc9f35cc3f0c6726427c3f1a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180309122231eucas1p1b8e0a85a73b31aa07eac08f809face6e
X-RootMTR: 20180309122231eucas1p1b8e0a85a73b31aa07eac08f809face6e
References: <CGME20180309122231eucas1p1b8e0a85a73b31aa07eac08f809face6e@eucas1p1.samsung.com>
        <1520598128-11768-1-git-send-email-m.purski@samsung.com>
        <20180309124234.GC5252@sirena.org.uk> <20180309155827.GS5799@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 04:58 PM, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [180309 12:43]:
>> On Fri, Mar 09, 2018 at 01:22:02PM +0100, Maciej Purski wrote:
>>
>>> I would like to kindly ask Fabio Estevam and Tony Lindgren to test the patch
>>> series on their boards.
> 
> I gave it a quick try and this set still causes at least mmc0
> to fail for me.
> 
> Regards,
> 
> Tony
> 
> 

Thanks. Here's a small patch, which adds some debugs. Maybe they will reveal,
where the problem is.

Best Regards,
Maciej Purski

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f1f11cf..0e80ba5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2280,7 +2280,6 @@ int regulator_enable(struct regulator *regulator)
  {
  	struct regulator_dev *rdev = regulator->rdev;
  	int ret = 0;
-	int ret2;

  	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
  		rdev_err(rdev, "not all coupled regulators registered\n");
@@ -2298,15 +2297,9 @@ int regulator_enable(struct regulator *regulator)

  	regulator_lock_dependent(rdev);
  	ret = _regulator_enable(rdev);
-	ret2 = regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+	regulator_balance_voltage(rdev, PM_SUSPEND_ON);
  	regulator_unlock_dependent(rdev);

-	if (ret2 != 0) {
-		rdev_err(rdev,
-			"balancing failed when trying to enable regulator: %d",
-			ret2);
-	}
-
  	if (ret != 0 && rdev->supply)
  		regulator_disable(rdev->supply);

@@ -3149,7 +3142,7 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
  		ret = regulator_set_voltage_unlocked(rdev->supply,
  				best_supply_uV, INT_MAX, state);
  		if (ret)
-			dev_err(&rdev->dev, "Failed to decrease supply voltage: %d\n",
+			dev_warn(&rdev->dev, "Failed to decrease supply voltage: %d\n",
  					ret);
  		/* No need to fail here */
  		ret = 0;
@@ -3332,11 +3325,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
  		ret = regulator_set_voltage_rdev(best_rdev, best_uV,
  						 best_uV, state);

-		if (ret < 0) {
-			rdev_err(rdev,
-				"Failed to set voltage with error: %d", ret);
+		if (ret < 0)
  			goto out;
-		}
  	}

  out:
