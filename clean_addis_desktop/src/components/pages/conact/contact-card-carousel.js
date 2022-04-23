import React from "react";
import { Swiper, SwiperSlide } from "swiper/react";
import cardBg from "../../src/components/img/cac.jng";

const ContactCardCarousel = () => {
  const swiperOptions = {
    spaceBetween: 30,
    slidesPerView: 3,
    breakpoints: {
      0: {
        spaceBetween: 0,
        slidesPerView: 1
      },
      480: {
        spaceBetween: 0,
        slidesPerView: 1
      },
      767: {
        spaceBetween: 30,
        slidesPerView: 2
      },
      1199: {
        spaceBetween: 30,
        slidesPerView: 3
      }
    }
  };
  return (
    <div className="contact-card-carousel ">
      <div className="container">
        <Swiper {...swiperOptions}>
          <SwiperSlide>
            <div
              className="contact-card d-flex flex-column text-center justify-content-center align-items-center background-secondary"
              style={{ backgroundImage: `url(${cardBg})` }}
            >
              <i aria-label="contact icon" className="azino-icon-family"></i>
              <h3>About</h3>
              <p>
              “Environmental cleanliness begins with individual desire to be clean.”
              Our main goal is, <br />  to make our city clean and beautiful.

                 <br /> 
              </p>
            </div>
          </SwiperSlide>
          <SwiperSlide>
            <div
              className="contact-card d-flex flex-column text-center justify-content-center align-items-center background-primary"
              style={{ backgroundImage: `url(${cardBg})` }}
            >
              <i aria-label="contact icon" className="azino-icon-address"></i>
              <h3>Address</h3>
              <p>
                Miyaziya 27 Street, <br /> AddisAbaba,Ethiopia{" "}
                <br /> Ethiopia.
              </p>
            </div>
          </SwiperSlide>
          <SwiperSlide>
            <div
              className="contact-card d-flex flex-column text-center justify-content-center align-items-center background-special"
              style={{ backgroundImage: `url(${cardBg})` }}
            >
              <i aria-label="contact icon" className="azino-icon-contact"></i>
              <h3>Contact</h3>
              <p>
                <a href="mailto:">CleanAddis@gmail.com</a> <br />{" "}
                <a href="tel:0927943593">0927943593</a>
              </p>
            </div>
          </SwiperSlide>
        </Swiper>
      </div>
    </div>
  );
};

export default ContactCardCarousel;